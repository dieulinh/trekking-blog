module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :email
      expose :authentication_token
    end
  end
end
