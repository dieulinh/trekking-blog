module Types
  class TrekkerType < Types::BaseObject
    field :role, String, null: false
    field :id, String, null: false
    field :location, String, null: false
    field :description, String, null: true
    field :trekker_name, String, null: true
    field :searchable_term, String, null: true

    def searchable_term
      [object.role, object.trekker_name, object.location, object.description].compact.join(' ')
    end
  end
end
