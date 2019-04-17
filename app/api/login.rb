class Login < Grape::API
  format :json
  namespace :login do
    desc 'Login enpoint'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post '/' do
      user = User.find_by(email: params[:email])
    end
  end
end