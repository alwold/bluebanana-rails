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

ActiveRecord::Schema.define(:version => 20120812211119) do

  create_table "checkins", :force => true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "events", :force => true do |t|
    t.string   "eventbrite_id"
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.string   "hashtag"
    t.text     "description"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "foursquare_venue_id"
  end

  create_table "meetings", :force => true do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.integer "acquiantance_id"
    t.string  "acquaintance_first_name"
    t.string  "acquaintance_last_name"
    t.string  "acquaintance_source"
    t.string  "notes"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "twitter_handle"
    t.string   "twitter_oauth_token"
    t.string   "twitter_oauth_secret"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "foursquare"
    t.string   "googleplus"
    t.string   "homepage"
    t.string   "phone"
    t.string   "company"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["twitter_handle"], :name => "index_users_on_twitter_handle", :unique => true
  add_index "users", ["twitter_oauth_token", "twitter_oauth_secret"], :name => "index_users_on_twitter_oauth_token_and_twitter_oauth_secret"

end
