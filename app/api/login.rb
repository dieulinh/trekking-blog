class Login < Grape::API
  format :json
  namespace :login do
    desc 'Login enpoint'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post '/' do
    end
  end
end