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

ActiveRecord::Schema[7.2].define(version: 2024_10_18_141736) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "week_id", null: false
    t.bigint "theme_id", null: false
    t.integer "days", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "year_id", null: false
    t.index ["theme_id"], name: "index_logs_on_theme_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
    t.index ["week_id"], name: "index_logs_on_week_id"
    t.index ["year_id"], name: "index_logs_on_year_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.bigint "year_id", null: false
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "starting_at"
    t.date "ending_at"
    t.index ["year_id"], name: "index_weeks_on_year_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "logs", "themes"
  add_foreign_key "logs", "users"
  add_foreign_key "logs", "weeks"
  add_foreign_key "logs", "years"
  add_foreign_key "weeks", "years"
end
