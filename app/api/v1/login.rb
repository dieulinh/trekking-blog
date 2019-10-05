module V1
  class Login < Grape::API
    version 'v1', using: :path
    namespace :login do
      desc 'Login endpoint'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post '/' do
        user = User.find_by(email: params[:email].downcase)
        return unauthorized! unless user && user.valid_password?(params[:password])
        encoded_user = ::JsonWebToken.encode(user_id: user.id, auth_token: user.authentication_token) if user
        present encoded_user
      end

      desc 'Register endpoint'
      params do
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post '/register' do
        return render_api_error!('password and password confirmation does not match', 422) unless params[:password] == params[:password_confirmation]
        email = params[:email].downcase
        user = User.find_by(email: email)
        return render_api_error!('User existed', 422) if user
        user = User.create(email: email, password: params[:password], password_confirmation: params[:password_confirmation])
        present user, with: Entities::User, status: 201
      end
    end
  end
end
