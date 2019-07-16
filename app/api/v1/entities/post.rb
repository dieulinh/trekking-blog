module V1
  module Entities
    class Post < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose :content
      expose :updated_at
      expose :slug
      expose :post_image

      def post_image
        Rails.application.routes.url_helpers.rails_blob_url(object.post_thumbnails, only_path: true) if object.post_thumbnails
      end
    end
  end
end
