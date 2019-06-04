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

ActiveRecord::Schema.define(version: 2015_11_16_172006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "currency", null: false
    t.string "title", null: false
    t.string "memo", default: "", null: false
    t.boolean "default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgets", id: :serial, force: :cascade do |t|
    t.integer "period_id", null: false
    t.integer "category_id", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.integer "spent_cents", default: 0, null: false
    t.integer "balance_cents", default: 0, null: false
    t.string "currency", null: false
    t.string "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", id: :serial, force: :cascade do |t|
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.string "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", id: :serial, force: :cascade do |t|
    t.float "ask", null: false
    t.float "bid", null: false
    t.float "rate", null: false
    t.string "from", null: false
    t.string "to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reconciliations", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "delta_cents", default: 0, null: false
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "direction", default: 0, null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "calculated_amount_cents", default: 0, null: false
    t.string "calculated_amount_currency", default: "USD", null: false
    t.float "rate", default: 1.0, null: false
    t.integer "category_id"
    t.integer "transfer_id"
    t.string "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", id: :serial, force: :cascade do |t|
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.integer "from_account_id", null: false
    t.integer "to_account_id", null: false
  end

end
