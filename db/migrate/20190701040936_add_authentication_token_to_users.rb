class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :users, :authentication_token, :string
    add_column :users, :authentication_token_created_at, :datetime

    add_index :users, :authentication_token, unique: true
  end

  def self.down
    remove_column :users, :authentication_token
  end
end
