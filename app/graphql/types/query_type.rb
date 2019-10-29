module Types
  class QueryType < Types::BaseObject

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :trekkers,
      [Types::TrekkerType],
      null: false,
      description: "Returns a list of trekkers in the database"

    def trekkers
      Trekker.all
    end
  end
end
