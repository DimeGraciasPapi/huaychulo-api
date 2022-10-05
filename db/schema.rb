# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_05_160128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "dishes", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name"
    t.float "price"
    t.integer "quantity"
    t.text "description"
    t.integer "waiting_time"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_dishes_on_category_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "order_id", null: false
    t.integer "quantity"
    t.float "sub_total", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_order_details_on_dish_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "table_id", null: false
    t.float "total", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_orders_on_table_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "pavilion"
    t.string "code"
    t.integer "chairs"
    t.string "image"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_tables_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "type"
    t.string "name"
    t.string "last_name"
    t.string "document"
    t.string "password_digest"
    t.float "intake", default: 0.0
    t.integer "document_type"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_users_on_document", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "dishes", "categories"
  add_foreign_key "order_details", "dishes"
  add_foreign_key "order_details", "orders"
  add_foreign_key "orders", "tables"
  add_foreign_key "orders", "users"
end
