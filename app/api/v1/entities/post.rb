module V1
  module Entities
    class Post < Grape::Entity
      format_with :timestamp do |date|
        date.strftime('%b %d, %Y')
      end

      expose :id
      expose :title
      expose :description
      expose :category
      expose :content
      expose :updated_at, format_with: :timestamp
      expose :slug
      expose :thumb_url
      expose :comments
    end
  end
end
