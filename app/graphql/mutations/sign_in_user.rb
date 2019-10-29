module Mutations
  class SignInUser < BaseMutation
    null false
    argument :email, Types::AuthProviderEmailInput, required: false
    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(email: nil)
      return unless email
      user = User.find_by_email email[:email]
      return unless user
      return unless user.valid_password?(email[:password])
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      { user: user, token: token }
    end
  end
end
