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

ActiveRecord::Schema[8.1].define(version: 2026_06_08_143727) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "imports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "error_message"
    t.string "source_platform"
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_imports_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "buy_fill_id"
    t.datetime "created_at", null: false
    t.integer "duration_seconds"
    t.decimal "entry_price"
    t.datetime "entry_time"
    t.decimal "exit_price"
    t.datetime "exit_time"
    t.decimal "fees"
    t.decimal "gross_pnl"
    t.bigint "import_id", null: false
    t.decimal "net_pnl"
    t.integer "quantity"
    t.string "sell_fill_id"
    t.string "side"
    t.string "status"
    t.string "symbol"
    t.decimal "tick_size"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["import_id"], name: "index_trades_on_import_id"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "imports", "users"
  add_foreign_key "trades", "imports"
  add_foreign_key "trades", "users"
end
