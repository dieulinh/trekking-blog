class AddCategoryToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :category, :integer, default: 0
  end
end
