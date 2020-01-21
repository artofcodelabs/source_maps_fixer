# frozen_string_literal: true

require 'test_helper'
require 'rake'

class PrepareTest < ActiveSupport::TestCase
  APP_JS_MAP_FILENAME = 'application.js-0c3ca5eaf24d04fc657ba1de3511dec1c1bb214ee56ce9074c19a273160869a1.map'
  APP_CSS_MAP_FILENAME = 'application.css-955bd5a4593a7de76455672f49e450d0b278304b00ad4008028ebceedd47311a.map'

  def setup
    Rake::Task['assets:prepare'].invoke
  end

  def teardown
    FileUtils.rm_r assets_path
  end

  test 'existence of files' do
    assert File.file?(path_to(APP_JS_MAP_FILENAME))
    assert File.file?(path_to(APP_CSS_MAP_FILENAME))

    assert_equal APP_JS_MAP_FILENAME, extract_source_map_filename(last_line(app_path('js')))
    assert_equal APP_CSS_MAP_FILENAME, extract_source_map_filename(last_line(app_path('css')))

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

  def last_line(file_path)
    File.readlines(file_path)[-1]
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
    line.split('sourceMappingURL=').last.chomp.sub(';', '').sub('*/', '')
  end
end
