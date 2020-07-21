# frozen_string_literal: true

require 'test_helper'
require 'rake'

class PrepareTest < ActiveSupport::TestCase
  APP_JS_MAP_FILENAME = 'application.js-57c991b36a542c6e53161813af37cf47b1da09d0c3b3d2c3ece0d308b1c2c2f9.map'
  APP_CSS_MAP_FILENAME = 'application.css-45024a8b10a4e0136a4e44dcc6424908240d0df9bbc64f6b8a08aae8f78c9ab2.map'

  def setup
    Rake::Task['assets:prepare'].invoke
  end

  def teardown
    FileUtils.rm_r assets_path
  end

  test 'existence of files' do
    assert File.file?(path_to(APP_JS_MAP_FILENAME))
    assert File.file?(path_to(APP_CSS_MAP_FILENAME))

    assert_equal APP_JS_MAP_FILENAME, extract_source_map_filename(last_line(app_path('js'), -2))
    assert_equal APP_CSS_MAP_FILENAME, extract_source_map_filename(last_line(app_path('css'), -2))

    assert File.file?(app_path('js.gz'))
    assert File.file?(app_path('css.gz'))
  end

  private

  def path_to(file_name)
    File.join assets_path, file_name
  end

  def assets_path
    File.join Rails.root, 'public', 'assets'
  end

  def last_line(file_path, offset = -1)
    File.readlines(file_path)[offset]
  end

  def assets
    `ls #{assets_path}`.split("\n")
  end

  def app_filename(ext)
    assets.find { |name| name =~ /application\-[0-9a-f]+\.#{ext}/ }
  end

  def app_path(ext)
    File.join assets_path, app_filename(ext)
  end

  def extract_source_map_filename(line)
    line.split('sourceMappingURL=').last.chomp.sub('*/', '')
  end
end
