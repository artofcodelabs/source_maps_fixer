# frozen_string_literal: true

require 'source_maps_fixer/railtie'

module SourceMapsFixer
  module Path
    module_function

    def files_with_source_maps(filter = '')
      Dir.glob("#{Rails.root.join 'app', 'assets'}/**/*")
         .grep(/#{filter}\.map\Z/)
         .to_h { |name| [name.sub('.map', ''), name] }
    end

    def digest_path(file_name)
      Rails.application.assets.find_asset(file_name).digest_path
    end

    def self.source_mapping_url(file_name)
      case file_name.match?(/\.css/) ? :css : :js
      when :css
        %(/*# sourceMappingURL=#{file_name}*/)
      when :js
        %(//# sourceMappingURL=#{file_name})
      end
    end
  end

  module ReplaceLinksWithPredicted
    module_function

    def call
      Path.files_with_source_maps.each do |asset_path, sm_path|
        new_content = File.read(asset_path).sub(
          Path.source_mapping_url(File.basename(sm_path)),
          "#{Path.source_mapping_url(Path.digest_path(sm_path))}\n\n"
        )
        File.write(asset_path, new_content)
      end
    end

    def undo
      Path.files_with_source_maps.each do |asset_path, sm_path|
        new_content = File.read(asset_path).sub(
          "#{Path.source_mapping_url(Path.digest_path(sm_path))}\n\n",
          Path.source_mapping_url(File.basename(sm_path))
        )
        File.write(asset_path, new_content)
      end
    end
  end

  module FixCompiled
    module_function

    def call
      Path.files_with_source_maps('js').each do |asset_path, _sm_path|
        public_path = Dir.glob("#{Rails.root.join 'public', 'assets'}/**/*")
                         .find do |path|
                           File.basename(path) == Path.digest_path(asset_path)
                         end
        lines = File.readlines(public_path)
        next unless lines[-2] == "//!\n" && lines[-1] == ";\n"

        File.write(public_path, lines[0..-3].join)
      end
    end
  end
end
