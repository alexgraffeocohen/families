# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140414151450) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.string   "permissions"
  end

  create_table "conversations", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "family_id"
    t.string   "permissions"
    t.integer  "person_id"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  create_table "families", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_slug"
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.integer  "age"
    t.datetime "birthday"
    t.string   "location"
    t.integer  "mother_id"
    t.integer  "father_id"
    t.integer  "admin"
    t.integer  "spouse_id"
    t.string   "gender"
    t.string   "phone"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "profile_photo"
  end

  add_index "people", ["confirmation_token"], name: "index_people_on_confirmation_token", unique: true
  add_index "people", ["email"], name: "index_people_on_email", unique: true
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true

  create_table "person_families", force: true do |t|
    t.integer  "person_id"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
    t.string   "data"
  end

end
