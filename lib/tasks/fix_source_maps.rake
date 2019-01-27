# frozen_string_literal: true

namespace :assets do
  desc 'Fixess source maps'

  task fix_source_maps: [:environment] do
    puts 'Fixing source maps...'
    files_with_source_maps.each do |file_name, sm_name|
      fix_source_mapping_url file_name, sm_name
    end
    puts 'Source maps have been fixed!'
  end

  private

  def files_with_source_maps
    Dir.glob("#{Rails.root.join 'app', 'assets'}/**/*")
       .find_all { |name| name =~ /\.map\Z/ }
       .map { |name| [name.sub('.map', ''), name] }
       .to_h
  end

  def source_mapping_url file_name
    case file_name.match?(/\.css/) ? :css : :js
    when :css
      "/*# sourceMappingURL=#{file_name}*/"
    when :js
      "//# sourceMappingURL=#{file_name}"
    end
  end

  def digest_path file_name
    Rails.application.assets.find_asset(file_name).digest_path
  end

  def fix_source_mapping_url file_name, sm_name
    new_content = File.read(file_name).sub(
      source_mapping_url(File.basename(sm_name)),
      source_mapping_url(digest_path(sm_name))
    )
    File.open(file_name, 'w') { |file| file.puts new_content }
  end
end
