class ChangeIdToUuidInTrekkers < ActiveRecord::Migration[5.2]
  def change
    add_column :trekkers, :uuid, :uuid, null: false, default: 'uuid_generate_v4()'
    remove_column :trekkers,    :id
    rename_column :trekkers,    :uuid, :id
    execute "ALTER TABLE trekkers    ADD PRIMARY KEY (id);"
    add_index :trekkers,    :created_at
  end
end
