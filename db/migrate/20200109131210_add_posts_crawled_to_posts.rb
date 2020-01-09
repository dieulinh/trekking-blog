class AddPostsCrawledToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_external, :boolean, default: false
    add_column :posts, :original_url, :string
  end
end
