module V1
  module Entities
    class Post < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose :content
      expose :updated_at
      expose :slug
      expose :thumb_url
    end
  end
end
