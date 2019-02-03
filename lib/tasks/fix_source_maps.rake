# frozen_string_literal: true

namespace :assets do
  desc 'Fix URLs to source maps'
  task fix_source_maps: [:environment] do
    puts 'Fixing URLs to source maps...'
    SourceMapsFixer::Executor.call
    puts 'URLs to source maps have been fixed!'
  end

  desc 'Revert fixed URLs to source maps'
  task undo_fix_source_maps: [:environment] do
    puts 'Reverting fixed URLs to source maps...'
    SourceMapsFixer::Executor.undo
    puts 'URLs to source maps have been reverted!'
  end
end
