# frozen_string_literal: true

namespace :assets do
  desc 'Fixes source maps'

  task fix_source_maps: [:environment] do
    puts 'Fixing source maps...'
    SourceMapsFixer::Executor.call
    puts 'Source maps have been fixed!'
  end

  task revert_fix_source_maps: [:environment] do
    puts 'Reverting source maps...'
    SourceMapsFixer::Executor.undo
    puts 'Source maps have been reverted!'
  end
end
