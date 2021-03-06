# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_19_204620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "wallpaper_id"
    t.bigint "wallpaper_price_id"
    t.bigint "cart_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["wallpaper_id"], name: "index_cart_items_on_wallpaper_id"
    t.index ["wallpaper_price_id"], name: "index_cart_items_on_wallpaper_price_id"
  end

  create_table "carts", force: :cascade do |t|
    t.float "total_amount", default: 0.0
    t.integer "status", default: 0
    t.float "discounts", default: 0.0
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "order_items", force: :cascade do |t|
    t.float "discounts"
    t.float "quantity"
    t.bigint "order_id"
    t.bigint "wallpaper_id"
    t.bigint "wallpaper_price_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["wallpaper_id"], name: "index_order_items_on_wallpaper_id"
    t.index ["wallpaper_price_id"], name: "index_order_items_on_wallpaper_price_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "payment_method"
    t.integer "status"
    t.float "total_amount", default: 0.0
    t.bigint "user_id"
    t.bigint "cart_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "wallpaper_prices", force: :cascade do |t|
    t.float "price"
    t.bigint "wallpaper_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["wallpaper_id"], name: "index_wallpaper_prices_on_wallpaper_id"
  end

  create_table "wallpapers", force: :cascade do |t|
    t.string "filename"
    t.text "description"
    t.string "file"
    t.string "path"
    t.integer "qty_available"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_wallpapers_on_deleted_at"
    t.index ["user_id"], name: "index_wallpapers_on_user_id"
  end

end
