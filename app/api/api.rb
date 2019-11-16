class API < Grape::API
  format :json
  rescue_from :all, backtrace: true
  helpers ::Shared::Helpers

  helpers do
    def warden
      env['warden']
    end

    def authenticated
      return true if warden.authenticated?
      token && @user = User.find_by_authentication_token(token)
    end

    def current_user
      warden.authenticate || @user
    end

    def token
      params[:user_token].presence
    end
  end

  mount V1::Login
  mount V1::Posts
  mount V1::Uploads
  mount V1::Users
  mount V1::Visitors

  rescue_from Grape::Exceptions::ValidationErrors  do |e|
    rack_response({
      status: e.status,
      error_msg: e.message
  }.to_json, 400)
  end
end
