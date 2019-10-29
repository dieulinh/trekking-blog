module Types
  class UserType < Types::BaseObject
    field :ID, String, null: false
    field :email, String, null: false

  end
end
