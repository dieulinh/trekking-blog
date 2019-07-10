Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['TREKKING_APP_URL'], 'http://www.eagertrekker.com'

    resource '*',
             headers: ["XMLHttpRequest", "Origin", "X-Requested-With", "Content-Type", "Accept", "Z-Key", "Charset", "Authorization", "Type"],
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
             max_age: 0
  end
end
