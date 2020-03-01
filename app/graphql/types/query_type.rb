module Types
  class QueryType < Types::BaseObject

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :posts, [Types::PostType], null: false do
      description "Return of list all posts"
      argument :category, String, required: false

    end
    field :trekkers,
      [Types::TrekkerType],
      null: false,
      description: "Returns a list of trekkers in the database"
    field :post, PostType, null: true do
      description "find post by id"
      argument :id, ID, required: true

    end
    def trekkers
      Trekker.all
    end

    def posts(category: nil)
      Post.order('updated_at desc').limit(100)
      if category
        Post.where(category: category).order('updated_at desc').limit(100)
      end
    end

    def post(id:)
      Post.find(id)
    end
  end
end
