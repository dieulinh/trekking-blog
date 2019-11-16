module V1
  module Params
    module Pagination
      extend Grape::API::Helpers

      params :pagination_params do
        optional :size, type: Integer, default: 10
        optional :page, type: Integer, default: 1
      end
    end
  end
end
