class AddIndexToTrekkers < ActiveRecord::Migration[5.2]
  def change
    rename_column :trekkers, :trekker_lonlat, :location_lonlat
    add_index :trekkers, :location_lonlat, using: :gist
  end
end
