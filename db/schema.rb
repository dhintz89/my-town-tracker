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

ActiveRecord::Schema.define(version: 2019_05_30_185823) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "place_recs", force: :cascade do |t|
    t.integer "place_id"
    t.integer "recommendation_id"
  end

  create_table "places", force: :cascade do |t|
    t.integer "user_id"
    t.string "category_id"
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state_abbr"
    t.integer "visited"
    t.string "tagline"
    t.string "notes"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "email"
    t.string "city"
  end

end
