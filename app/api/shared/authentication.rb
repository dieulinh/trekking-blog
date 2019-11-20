module Shared
  module Authentication
    extend Grape::API::Helpers
    def authenticate_user!
      return unauthorized! unless request.headers['Authorization']
      token_header = request.headers['Authorization'].split(' ')[1]

      return unauthorized! unless token_header

      decoded_token = JsonWebToken.decode(token_header)[0].to_h.symbolize_keys
      return unauthorized! unless decoded_token.key?(:user_id)
      @user = User.find decoded_token[:user_id]
      return unauthorized! unless @user
      true
    end

    def current_user
      @user
    end
  end
end
