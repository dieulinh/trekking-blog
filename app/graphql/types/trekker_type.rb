module Types
  class TrekkerType < Types::BaseObject
    field :role, String, null: false
    field :id, String, null: false
    field :location, String, null: false
    field :description, String, null: true
    field :trekker_name, String, null: true
  end
end
