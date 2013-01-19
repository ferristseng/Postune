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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130119190103) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "permission"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reset_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_token"
    t.datetime "expires"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "songs", :force => true do |t|
    t.text     "path"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.string   "artwork"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "station_collaborators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "station_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "station_history_items", :force => true do |t|
    t.integer  "song_id"
    t.datetime "played"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_station_favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "station_id"
    t.boolean  "favorite"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "activation_code"
    t.integer  "group_id"
    t.boolean  "is_active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "salt"
    t.datetime "last_sign_in"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
