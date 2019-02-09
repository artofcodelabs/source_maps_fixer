# frozen_string_literal: true

namespace :assets do
  desc 'Fix URLs to source maps and compile assets'
  task prepare: [:environment] do
    SourceMapsFixer::Executor.call
    Rake::Task['assets:precompile'].invoke
    SourceMapsFixer::Executor.undo
    puts 'Assets have been prepared!'
  end
end
