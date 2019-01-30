# frozen_string_literal: true

require 'test_helper'
require 'rake'

class FixSourceMapsTest < ActiveSupport::TestCase
  SM_URL_CSS = '/*# sourceMappingURL=application.css-955bd5a4593a7de76455672f49e450d0b278304b00ad4008028ebceedd47311a.map*/'
  SM_URL_JS = '//# sourceMappingURL=application.js-0c3ca5eaf24d04fc657ba1de3511dec1c1bb214ee56ce9074c19a273160869a1.map'

  def setup
    Dummy::Application.load_tasks
    Rake::Task['assets:fix_source_maps'].invoke
  end

  def teardown
    `git checkout #{path_to('application.css')}`
    `git checkout #{path_to('application.js')}`
  end

  test 'changes sourceMappingURL to the digest version' do
    assert_equal SM_URL_CSS, last_line(path_to('application.css'))
    assert_equal SM_URL_JS, last_line(path_to('application.js'))
  end

  private

  def path_to file_name
    File.join Rails.root, 'app', 'assets', 'output', file_name
  end

  def last_line file_path
    File.readlines(file_path)[-1].strip
  end
end
