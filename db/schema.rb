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

ActiveRecord::Schema.define(version: 2021_03_08_102059) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "postal_code"
    t.string "city"
    t.string "province"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "addresses_profiles", id: false, force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "from"
    t.datetime "to"
    t.index ["address_id"], name: "index_addresses_profiles_on_address_id"
    t.index ["profile_id"], name: "index_addresses_profiles_on_profile_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.integer "start"
    t.bigint "end"
    t.boolean "allDay", default: false
    t.string "backgroundColor"
    t.string "borderColor"
    t.text "daysOfWeek"
    t.text "startTime"
    t.text "endTime"
    t.boolean "fixed", default: false
    t.boolean "recurring", default: false
  end

  create_table "certifications", force: :cascade do |t|
    t.string "institute"
    t.string "level"
    t.string "name"
    t.datetime "from"
    t.datetime "to"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_certifications_on_profile_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "task"
    t.string "company"
    t.string "time"
    t.datetime "from"
    t.datetime "to"
    t.text "description"
    t.integer "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_id"
    t.text "company_image64"
    t.string "company_website"
    t.index ["address_id"], name: "index_jobs_on_address_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "employment"
    t.text "description"
    t.text "image64"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "jobs", "profiles"
end
