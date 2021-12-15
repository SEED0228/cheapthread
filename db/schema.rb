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

ActiveRecord::Schema.define(version: 2021_12_15_164931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cheap_threads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "comment_number", default: 0, null: false
    t.string "title", null: false
    t.bigint "end_user_id"
    t.bigint "list_id", null: false
    t.bigint "nanj_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "initial_name", default: "風吹けば名無し"
    t.index ["end_user_id"], name: "index_cheap_threads_on_end_user_id"
    t.index ["list_id"], name: "index_cheap_threads_on_list_id"
    t.index ["nanj_id"], name: "index_cheap_threads_on_nanj_id"
  end

  create_table "end_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.string "profile_image_id", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_end_users_on_reset_password_token", unique: true
  end

  create_table "list_elements", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", default: 0
    t.text "introduction"
    t.integer "list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "calorie", default: 0
    t.index ["name"], name: "index_list_elements_on_name"
  end

  create_table "lists", force: :cascade do |t|
    t.integer "view_counter", default: 0, null: false
    t.string "title", null: false
    t.text "introduction"
    t.boolean "contains_price", default: true, null: false
    t.integer "end_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "contains_calorie", default: false
    t.boolean "is_public", default: true
    t.string "color", default: "#007c00", null: false
    t.string "text_color", default: "#d70002", null: false
    t.index ["title"], name: "index_lists_on_title", unique: true
  end

  create_table "nanjs", force: :cascade do |t|
    t.string "ip_address", null: false
    t.string "random_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "thread_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "comment", null: false
    t.string "user_id", null: false
    t.bigint "end_user_id"
    t.uuid "cheap_thread_id", null: false
    t.bigint "nanj_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "email"
    t.integer "number"
    t.index ["cheap_thread_id"], name: "index_thread_comments_on_cheap_thread_id"
    t.index ["end_user_id"], name: "index_thread_comments_on_end_user_id"
    t.index ["nanj_id"], name: "index_thread_comments_on_nanj_id"
  end

  add_foreign_key "cheap_threads", "end_users"
  add_foreign_key "cheap_threads", "lists"
  add_foreign_key "cheap_threads", "nanjs"
  add_foreign_key "thread_comments", "cheap_threads"
  add_foreign_key "thread_comments", "end_users"
  add_foreign_key "thread_comments", "nanjs"
end
