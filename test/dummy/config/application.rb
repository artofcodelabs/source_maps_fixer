# frozen_string_literal: true

require_relative 'boot'

%w(
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  require railtie
end

Bundler.require(*Rails.groups)
require 'source_maps_fixer'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
