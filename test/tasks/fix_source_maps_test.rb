# frozen_string_literal: true

require 'test_helper'
require 'rake'

class FixSourceMapsTest < ActiveSupport::TestCase
  def setup
    Rake::Task['assets:fix_source_maps'].invoke
  end

  def teardown
    SourceMapsFixer::ReplaceLinksWithPredicted.undo
  end

  test 'changes sourceMappingURL to the digest version' do
    assert_equal '/*# sourceMappingURL=application.css-45024a8b10a4e0136a4e44dcc6424908240d0df9bbc64f6b8a08aae8f78c9ab2.map*/', last_line(path_to_js_bundle('application.css'), -2)
    assert_equal '//# sourceMappingURL=application.js-57c991b36a542c6e53161813af37cf47b1da09d0c3b3d2c3ece0d308b1c2c2f9.map', last_line(path_to_js_bundle('application.js'), -2)
  end

  def last_line(file_path, offset = -1)
    File.readlines(file_path)[offset].strip
  end

  private

  def path_to_js_bundle(file_name)
    File.join(Rails.root, 'app', 'assets', 'output', file_name)
  end
end
