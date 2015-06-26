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

ActiveRecord::Schema.define(version: 20150626225720) do

  create_table "event_revisions", force: :cascade do |t|
    t.integer  "schedule_event_id", limit: 4
    t.integer  "home_score",        limit: 4
    t.integer  "away_score",        limit: 4
    t.integer  "status",            limit: 4
    t.integer  "period",            limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "event_revisions", ["schedule_event_id"], name: "index_event_revisions_on_schedule_event_id", using: :btree

  create_table "schedule_events", force: :cascade do |t|
    t.integer  "home_season_id", limit: 4
    t.integer  "away_season_id", limit: 4
    t.integer  "home_score",     limit: 4
    t.integer  "away_score",     limit: 4
    t.integer  "status",         limit: 4
    t.integer  "period",         limit: 4
    t.datetime "date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "guest_name",     limit: 255
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "location",     limit: 255
    t.string   "tz_name",      limit: 255
    t.string   "picture",      limit: 255
    t.string   "abbreviation", limit: 255
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "sport_id",   limit: 4
    t.integer  "school_id",  limit: 4
    t.integer  "year",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "seasons", ["school_id"], name: "index_seasons_on_school_id", using: :btree
  add_index "seasons", ["sport_id"], name: "index_seasons_on_sport_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "male",       limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "sport_id",   limit: 4
    t.integer  "school_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "teams", ["school_id"], name: "index_teams_on_school_id", using: :btree
  add_index "teams", ["sport_id"], name: "index_teams_on_sport_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.integer  "role",       limit: 4
    t.integer  "school_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
