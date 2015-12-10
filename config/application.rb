require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module YiellohApi
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # this is the config that enables us to accept CORS requests from the Lukaduka API clients
    # https://github.com/cyu/rack-cors
    # config.middleware.use Rack::Cors do
    # https://github.com/cyu/rack-cors/issues/61
    # config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
    config.middleware.insert_before "Rack::Runtime", "Rack::Cors", logger: Rails.logger do
      allow do
        origins '*'
        # origins 'http://0.0.0.0:3000', 'http://192.168.0.16:9000', 'http://192.168.0.17', 'http://localhost:3000', 'http://127.0.0.1',
        #         'http://0:0:0:0:0:0:0:1', 'https://api.yielloh.com', 'https://www.yielloh.com', 'https://staging.yielloh.com',
        #         'http://api.lvh.me:3000'
        resource '*', :headers => :any, :methods => [:get, :post, :patch, :put, :delete, :options, :head]
      end
    end

    # using Rack::Attack allows us to whitelist, blacklist and throttle access to our API
    # https://github.com/kickstarter/rack-attack
    config.middleware.use Rack::Attack

    config.middleware.use ActionDispatch::Flash
    config.action_controller.allow_forgery_protection = false
  end
end
