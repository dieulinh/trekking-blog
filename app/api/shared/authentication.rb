module Shared
  module Authentication
    extend Grape::API::Helpers
    def authenticate_user!
      token = params.delete(:auth_token)
      return unauthorized unless token
      decoded_token = JsonWebToken.decode(token)[0].to_h.symbolize_keys
      return unauthorized unless decoded_token.key?(:user_id)

      @user = User.find_by(authentication_token: decoded_token[:auth_token])
      return unauthorized! unless @user
    end

    def current_user
      @user
    end
  end
end