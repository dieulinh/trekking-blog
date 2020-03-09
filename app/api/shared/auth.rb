module Shared
  module Auth
    extend Grape::API::Helpers
    def http_token
        @http_token ||= if headers['Authorization'].present?
          headers['Authorization'].split(' ').last
        end
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end

    def user_id_in_token?
      http_token && auth_token && auth_token[:user_id].to_i
    end
  end
end
