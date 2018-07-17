class CreateDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :datasets do |t|
      t.string :key, null:false
      t.string :title

      t.timestamps
    end
    add_index "datasets", ["key"], name: "index_datasets_on_key", unique: true, using: :btree
  end

end
