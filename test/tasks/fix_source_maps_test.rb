# frozen_string_literal: true

require 'test_helper'
require 'rake'

class FixSourceMapsTest < ActiveSupport::TestCase
  def setup
    Rake::Task['assets:fix_source_maps'].reenable
    Rake::Task['assets:fix_source_maps'].invoke
  end

  def teardown
    SourceMapsFixer::Executor.undo
  end

  test 'changes sourceMappingURL to the digest version' do
    assert_equal '/*# sourceMappingURL=application.css-955bd5a4593a7de76455672f49e450d0b278304b00ad4008028ebceedd47311a.map*/', last_line(path_to_js_bundle('application.css'))
    assert_equal '//# sourceMappingURL=application.js-0c3ca5eaf24d04fc657ba1de3511dec1c1bb214ee56ce9074c19a273160869a1.map', last_line(path_to_js_bundle('application.js'))
  end

  def last_line file_path
    File.readlines(file_path)[-1].strip
  end

  private

  def path_to_js_bundle file_name
    File.join Rails.root, 'app', 'assets', 'output', file_name
  end
end
