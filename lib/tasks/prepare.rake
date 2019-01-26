# frozen_string_literal: true

namespace :assets do
  desc 'Main task to prepare assets for deployment'

  task :prepare do
    system 'RAILS_ENV=development bin/rails assets:fix_source_maps'
    system 'RAILS_ENV=production bin/rails assets:precompile'
    puts 'Assets have been prepared!'
  end
end
