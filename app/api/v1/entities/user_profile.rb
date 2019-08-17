module V1
  module Entities
    class UserProfile < Grape::Entity
      format_with :timestamp do |date|
        date.strftime('%b %d, %Y')
      end
      expose :id
      expose :role
      expose :description
      expose :location
      expose :location_lonlat
      expose :created_at, format_with: :timestamp
    end
  end
end
