# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require "openid"
require "openid/extensions/sreg"
require "openid/extensions/pape"
require "openid/store/filesystem"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chatfuel
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults "6.0"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |generate|
      generate.test_framework :rspec, fixtures: false, helper_specs: false, routing_specs: false
      generate.fixture_replacement :factory_bot
      generate.factory_bot dir: "spec/factories"
      generate.helper false
      generate.assets false
      generate.view_spec false
    end

    console do
      ActiveRecord::Base.connection
    end

    config.active_job.queue_adapter = :sidekiq
    config.to_prepare do
      Devise::SessionsController.layout "devise"
    end
  end
end
