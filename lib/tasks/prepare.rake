# frozen_string_literal: true

namespace :assets do
  desc 'Fix URLs to source maps and compile assets'
  task prepare: [:environment] do
    SourceMapsFixer::ReplaceLinksWithPredicted.call
    Rake::Task['assets:precompile'].invoke
    SourceMapsFixer::ReplaceLinksWithPredicted.undo
    SourceMapsFixer::FixCompiled.call
    puts 'Assets have been prepared!'
  end
end
