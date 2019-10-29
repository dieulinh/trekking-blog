module Types
  class MutationType < Types::BaseObject
    field :create_trekker, mutation: Mutations::CreateTrekker
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
