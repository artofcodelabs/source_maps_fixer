# frozen_string_literal: true

require 'test_helper'
require 'rake'

class FixSourceMapsTest < ActiveSupport::TestCase
  include FixSourceMapsHelpers

  def setup
    Rake::Task['assets:fix_source_maps'].reenable
    Rake::Task['assets:fix_source_maps'].invoke
  end

  def teardown
    fix_source_maps_teardown
  end

  test 'changes sourceMappingURL to the digest version' do
    assert_equal COMPILED_CSS_SM_URL, last_line(path_to_js_bundle('application.css'))
    assert_equal COMPILED_JS_SM_URL, last_line(path_to_js_bundle('application.js'))
  end

  def last_line file_path
    File.readlines(file_path)[-1].strip
  end
end
