require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrekkingBlog
  class Application < Rails::Application
    config.load_defaults 5.2
    # Rails.application.config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins 'localhost:3000', 'localhost:3035'

    #     resource '/api/v1/posts',
    #              headers: :any,
    #              methods: [:get, :post, :put, :patch, :delete, :options, :head],
    #              expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
    #              max_age: 0
    #   end
    # end

    # Initialize configuration defaults for originally generated Rails version.


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

  end
end
