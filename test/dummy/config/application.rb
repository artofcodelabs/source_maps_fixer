# frozen_string_literal: true

require_relative 'boot'

%w[
  action_controller/railtie
  rails/test_unit/railtie
  sprockets/railtie
].each do |railtie|
  require railtie
end

Bundler.require(*Rails.groups)
require 'source_maps_fixer'

module Dummy
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end
