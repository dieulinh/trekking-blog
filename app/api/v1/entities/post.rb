module V1
  module Entities
    class Post < Grape::Entity
      expose :title
      expose :description
      expose :content
      expose :updated_at
    end
  end
end
