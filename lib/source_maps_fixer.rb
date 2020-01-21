# frozen_string_literal: true

require 'source_maps_fixer/railtie'

module SourceMapsFixer
  class Path
    def self.files_with_source_maps
      Dir.glob("#{Rails.root.join 'app', 'assets'}/**/*")
         .find_all { |name| name =~ /\.map\Z/ }
         .map { |name| [name.sub('.map', ''), name] }
         .to_h
    end

    def self.digest_path file_name
      Rails.application.assets.find_asset(file_name).digest_path
    end

    def self.source_mapping_url file_name
      case file_name.match?(/\.css/) ? :css : :js
      when :css
        %(/*# sourceMappingURL=#{file_name}*/)
      when :js
        %(//# sourceMappingURL=#{file_name})
      end
    end
  end

  class Executor
    def self.call
      Path.files_with_source_maps.each do |file_name, sm_name|
        new_content = File.read(file_name).sub(
          Path.source_mapping_url(File.basename(sm_name)),
          Path.source_mapping_url(Path.digest_path(sm_name))
        )
        File.open(file_name, 'w') { |file| file.write new_content }
      end
    end

    def self.undo
      Path.files_with_source_maps.each do |file_name, sm_name|
        new_content = File.read(file_name).sub(
          Path.source_mapping_url(Path.digest_path(sm_name)),
          Path.source_mapping_url(File.basename(sm_name))
        )
        File.open(file_name, 'w') { |file| file.write new_content }
      end
    end
  end
end
