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

ActiveRecord::Schema[7.0].define(version: 2023_02_19_164003) do
  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.string "publisher"
    t.integer "price"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "average_rating"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.integer "transaction_id"
    t.index ["book_id"], name: "index_carts_on_book_id"
    t.index ["transaction_id"], name: "index_carts_on_transaction_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_number"
    t.string "credit_card_number"
    t.string "address"
    t.string "phone_number"
    t.integer "quantity"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "credit_card_number"
    t.string "phone_number"
    t.integer "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "books"
  add_foreign_key "carts", "transactions"
  add_foreign_key "carts", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "transactions", "users"
end
