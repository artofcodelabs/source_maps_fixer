# frozen_string_literal: true

namespace :assets do
  desc 'Fixes source maps'

  task fix_source_maps: [:environment] do
    puts 'Fixing source maps...'
    SourceMapsFixer::Executor.call
    puts 'Source maps have been fixed!'
  end
end
