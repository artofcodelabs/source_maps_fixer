# frozen_string_literal: true

require 'test_helper'
require 'rake'

class PrepareTest < ActiveSupport::TestCase
  def setup
    Rake::Task['assets:prepare'].invoke
  end

  def teardown
    FileUtils.rm_r File.join(Rails.root, 'public', 'assets')
  end

  test 'existence of files' do
    assert File.file?(path_to('application.js-0c3ca5eaf24d04fc657ba1de3511dec1c1bb214ee56ce9074c19a273160869a1.map'))
    assert File.file?(path_to('application.css-955bd5a4593a7de76455672f49e450d0b278304b00ad4008028ebceedd47311a.map'))

    assert File.file?(path_to('application-5ef0d5f24e906a0eb73352d4e25133b092c219380c75b622e0f6eed60dfe5785.js'))
    assert File.file?(path_to('application-5ef0d5f24e906a0eb73352d4e25133b092c219380c75b622e0f6eed60dfe5785.js.gz'))

    assert File.file?(path_to('application-9e1b025beb7cab8061c1e58394f874261b9b5dc9aba7575b22ce33aa093d6f06.css'))
    assert File.file?(path_to('application-9e1b025beb7cab8061c1e58394f874261b9b5dc9aba7575b22ce33aa093d6f06.css.gz'))
  end

  private

  def path_to file_name
    File.join Rails.root, 'public', 'assets', file_name
  end
end
