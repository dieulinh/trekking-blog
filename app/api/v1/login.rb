module V1
  class Login < Grape::API
    version 'v1', using: :path
    namespace :login do
      desc 'Login enpoint'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post '/' do
        user = User.find_by(email: params[:email])
        return unauthorized! unless user && user.valid_password?(params[:password])
        present user, with: Entities::User
      end
    end
  end

end
