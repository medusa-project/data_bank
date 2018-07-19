# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_19_150514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "datafiles", force: :cascade do |t|
    t.bigint "dataset_id"
    t.string "web_id"
    t.string "storage_root"
    t.string "storage_key"
    t.string "storage_prefix"
    t.string "filename"
    t.bigint "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dataset_id"], name: "index_datafiles_on_dataset_id"
  end

  create_table "datasets", force: :cascade do |t|
    t.string "key", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_datasets_on_key", unique: true
  end

  add_foreign_key "datafiles", "datasets"
end
