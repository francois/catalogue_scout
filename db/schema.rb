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

ActiveRecord::Schema.define(version: 2018_02_15_042639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_log_records", force: :cascade do |t|
    t.string "type", null: false
    t.string "slug", null: false
    t.jsonb "meta", null: false
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_event_log_records_on_slug", unique: true
    t.index ["type"], name: "index_event_log_records_on_type"
  end

  create_table "events", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.date "begin_on", null: false
    t.date "end_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
    t.index ["slug"], name: "index_groups_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "group_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_products_on_group_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "product_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reservations_on_event_id"
    t.index ["product_id"], name: "index_reservations_on_product_id"
    t.index ["slug"], name: "index_reservations_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "events", "users"
  add_foreign_key "products", "groups"
  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "products"
  add_foreign_key "users", "groups"
end
