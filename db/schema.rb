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

ActiveRecord::Schema.define(version: 2018_07_01_011529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "person_oauth_accounts", force: :cascade do |t|
    t.bigint "person_person_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_person_id"], name: "index_person_oauth_accounts_on_person_person_id"
    t.index ["provider", "uid"], name: "index_person_oauth_accounts_on_provider_and_uid", unique: true
  end

  create_table "person_people", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "avatar_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "person_oauth_accounts", "person_people"
end
