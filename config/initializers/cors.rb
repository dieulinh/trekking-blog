# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins 'localhost:3000'

#     resource '*',
#       headers: :any,
#       methods:  :any? { |e|  }
#     end
#   end
# end
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
             max_age: 0
  end
end
