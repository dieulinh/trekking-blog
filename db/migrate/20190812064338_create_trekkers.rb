class CreateTrekkers < ActiveRecord::Migration[5.2]
  def change
    create_table :trekkers do |t|
      t.references :user, index: true
      t.integer :role, default: 0
      t.text :description, default: ''
      t.string :location, default: ''
      t.st_point :trekker_lonlat, geographic: true
      t.string :trekker_name
      t.timestamps
    end
  end
end
