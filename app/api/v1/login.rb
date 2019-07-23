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
        user = User.find_by(email: params[:email])
        return unauthorized! unless user && user.valid_password?(params[:password])
        present user, with: Entities::User
      end

      desc 'Register endpoint'
      params do
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post '/register' do
        user = User.find_by(email: params[:email])
        return render_api_error('User existed', 422) if user
        user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
        present user, with: Entities::User
      end
    end
  end

end
