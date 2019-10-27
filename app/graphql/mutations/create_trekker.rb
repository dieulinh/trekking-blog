module Mutations
  class CreateTrekker < BaseMutation
    argument :description, String, required: true
    argument :trekker_name, String, required: true
    argument :role, String, required: false
    argument :location, String, required: false
    argument :user_id, ID, required: true
    type Types::TrekkerType

    def resolve(description: nil, role: nil, trekker_name: nil, location: nil, user_id: nil)
      Trekker.create!(role: role, description: description, location: location, trekker_name: trekker_name, user_id: user_id)
    end
  end
end
