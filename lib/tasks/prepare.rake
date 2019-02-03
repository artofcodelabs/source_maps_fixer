# frozen_string_literal: true

namespace :assets do
  desc 'Main task to prepare assets for deployment'

  task :prepare do
    ENV['RAILS_ENV'] = 'development'
    Rake::Task['assets:fix_source_maps'].invoke
    ENV['RAILS_ENV'] = 'production'
    Rake::Task['assets:precompile'].invoke
    ENV['RAILS_ENV'] = 'development'
    Rake::Task['assets:revert_fix_source_maps'].invoke
    puts 'Assets have been prepared!'
  end
end
