module Types
  class PostType < Types::BaseObject
    description "A blog post"
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :content, String, null: true
    field :slug, String, null: true
    field :thumb_url, String, null: true
    field :category, String, null: true
    field :post_cover, String, null: true
    field :updated_at, String, null: false
    field :is_private, Boolean, null: false
  end
end
