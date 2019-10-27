module Types
  class QueryType < Types::BaseObject

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :trekkers,
      [Types::TrekkerType],
      null: false,
      description: "Returns a list of trekkers in the database"

    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World! I am from Test Field"
    end
    def trekkers
      Trekker.all
    end
  end
end
