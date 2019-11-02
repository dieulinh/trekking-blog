module Types
  class PostType < Types::BaseObject
    description "A blog post"
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :content, String, null: true
    field :slug, String, null: false
    field :category, String, null: true
  end
end
