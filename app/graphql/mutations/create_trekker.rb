module Mutations
  class CreateTrekker < BaseMutation
    argument :description, String, required: true
    argument :trekker_name, String, required: true
    argument :role, String, required: false
    argument :location, String, required: false
    argument :user_id, ID, required: true
    argument :lon, String, required: true
    argument :lat, String, required: true
    type Types::TrekkerType

    def resolve(description: nil, role: nil, trekker_name: nil, location: nil, user_id: nil, lon: nil, lat: nil)
      Trekker.create!(role: role, description: description, location: location, trekker_name: trekker_name, user_id: user_id,
        location_lonlat: "POINT(#{lon} #{lat})"
      )
    end
  end
end
