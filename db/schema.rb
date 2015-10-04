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

ActiveRecord::Schema.define(version: 20160828204424) do

  create_table "_points_old_20150916", force: :cascade do |t|
    t.float    "lng"
    t.float    "lat"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "rating",      default: 0
    t.string   "type"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "point_id"
  end

  add_index "comments", ["point_id"], name: "index_comments_on_point_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "media", force: :cascade do |t|
    t.integer  "comment_id"
    t.integer  "point_id"
    t.integer  "user_id"
    t.binary   "bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "media", ["comment_id"], name: "index_media_on_comment_id"
  add_index "media", ["point_id"], name: "index_media_on_point_id"
  add_index "media", ["user_id"], name: "index_media_on_user_id"

  create_table "news", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "news", ["point_id"], name: "index_news_on_point_id"
  add_index "news", ["user_id"], name: "index_news_on_user_id"

  create_table "points", force: :cascade do |t|
    t.float    "lng"
    t.float    "lat"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.integer  "rating",       default: 0
    t.string   "point_type"
    t.boolean  "isFulltime",   default: true
    t.boolean  "cardAccepted", default: false
    t.boolean  "beer",         default: true
    t.boolean  "hard",         default: true
    t.boolean  "elite",        default: false
  end

  add_index "points", ["user_id"], name: "index_points_on_user_id"

  create_table "rated_points", force: :cascade do |t|
    t.boolean  "direction"
    t.integer  "user_id"
    t.integer  "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rated_points", ["point_id"], name: "index_rated_points_on_point_id"
  add_index "rated_points", ["user_id"], name: "index_rated_points_on_user_id"

  create_table "settings", force: :cascade do |t|
    t.string   "json"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.datetime "last_seen"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
