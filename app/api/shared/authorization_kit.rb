module Shared
  module AuthorizationKit
    # extend Grape::API::Helpers
    def self.included(mod)
      # byebug
      # mod.after { verify_authorized }
      mod.helpers Pundit
    end
  end
end
