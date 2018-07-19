class CreateDatafiles < ActiveRecord::Migration[5.2]
  def change
    create_table :datafiles do |t|
      t.references :dataset, foreign_key: true
      t.string :web_id
      t.string :storage_root
      t.string :storage_key
      t.string :storage_prefix
      t.string :filename
      t.integer :size, limit: 8

      t.timestamps
    end
  end
end
