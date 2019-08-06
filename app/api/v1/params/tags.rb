module V1
  module Params
    module Tags
      extend Grape::API::Helpers

      params :tags_params do
          optional :tag1, type: Array[String]
          optional :terms, type: String
      end
    end
  end
end
