
module Geoable
  extend ActiveSupport::Concern

  included do
    include RGeo::ActiveRecord::SpatialExpressions
    scope :within, -> (latitude, longitude, distance_in_mile = 1) {
      where(%{
       ST_Distance(location_lonlat, 'POINT(%f %f)') < %d
      } % [longitude, latitude, distance_in_mile * 1609.34]) # approx
    }
  end
end
