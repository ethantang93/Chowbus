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

ActiveRecord::Schema.define(version: 20170412221645) do

  create_table "meals", force: :cascade do |t|
    t.text     "detail"
    t.integer  "Rest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meals", ["Rest_id"], name: "index_meals_on_Rest_id"

  create_table "rests", force: :cascade do |t|
    t.string   "name"
    t.text     "location"
    t.integer  "Zone_id"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "rests", ["Zone_id"], name: "index_rests_on_Zone_id"

  create_table "schedules", force: :cascade do |t|
    t.string   "day"
    t.integer  "Rest_id"
    t.integer  "Zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "schedules", ["Rest_id"], name: "index_schedules_on_Rest_id"
  add_index "schedules", ["Zone_id"], name: "index_schedules_on_Zone_id"

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
