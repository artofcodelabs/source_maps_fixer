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

  def assets_path
    Rails.root.join 'app', 'assets', 'assets'
  end

  def asset_path file_name
    File.join assets_path, file_name
  end

  def lang file_name
    file_name.match?(/\.css/) ? :css : :js
  end

  def files_with_source_maps
    Dir.entries(assets_path)
       .find_all { |name| name =~ /\.map\Z/ }
       .map { |name| [name.sub('.map', ''), name] }
       .to_h
  end

  def source_mapping_url file_name
    case lang(file_name)
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
    content = File.read asset_path(file_name)
    new_content = content.sub(
      source_mapping_url(sm_name),
      source_mapping_url(digest_path(sm_name))
    )
    File.open(asset_path(file_name), 'w') { |file| file.puts new_content }
  end
end
