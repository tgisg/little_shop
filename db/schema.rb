# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160916034205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_items", id: false, force: :cascade do |t|
    t.integer "item_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "item_orders", force: :cascade do |t|
    t.integer "quantity"
    t.integer "order_id"
    t.integer "item_id"
  end

  add_index "item_orders", ["item_id"], name: "index_item_orders_on_item_id", using: :btree
  add_index "item_orders", ["order_id"], name: "index_item_orders_on_order_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image_url"
    t.integer  "price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "retired",     default: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "status"
    t.integer  "total"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "role",                  default: 0
  end

  add_foreign_key "item_orders", "items"
  add_foreign_key "item_orders", "orders"
  add_foreign_key "orders", "users"
end
