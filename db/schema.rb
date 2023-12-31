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

ActiveRecord::Schema[7.0].define(version: 2023_07_16_225254) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_sessions", force: :cascade do |t|
    t.string "session_id"
    t.string "status", default: "initialized"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "rut"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_customers_on_account_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_session_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "intention", default: "none"
    t.index ["chat_session_id"], name: "index_messages_on_chat_session_id"
  end

  create_table "purchase_requests", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "address"
    t.integer "amount"
    t.integer "quantity"
    t.integer "total"
    t.date "deposit_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_purchase_requests_on_customer_id"
  end

  add_foreign_key "customers", "accounts"
  add_foreign_key "messages", "chat_sessions"
  add_foreign_key "purchase_requests", "customers"
end
