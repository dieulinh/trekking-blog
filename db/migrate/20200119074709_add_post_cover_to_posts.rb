class AddPostCoverToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_cover, :string
  end
end
