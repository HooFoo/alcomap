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

ActiveRecord::Schema.define(version: 20171015234202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree

  create_table "active_admin_managed_resources", force: :cascade do |t|
    t.string "class_name", null: false
    t.string "action",     null: false
    t.string "name"
  end

  add_index "active_admin_managed_resources", ["class_name", "action", "name"], name: "active_admin_managed_resources_index", unique: true, using: :btree

  create_table "active_admin_permissions", force: :cascade do |t|
    t.integer "managed_resource_id",                       null: false
    t.integer "role",                limit: 2, default: 0, null: false
    t.integer "state",               limit: 2, default: 0, null: false
  end

  add_index "active_admin_permissions", ["managed_resource_id", "role"], name: "active_admin_permissions_index", unique: true, using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audit_entries", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "admin_id"
    t.string   "resource_type"
    t.string   "event_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cathegories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "parent_id"
    t.integer  "items_count"
    t.string   "icon"
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "show",        default: true
  end

  create_table "cathegories_items", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "cathegory_id"
  end

  add_index "cathegories_items", ["cathegory_id"], name: "index_cathegories_items_on_cathegory_id", using: :btree
  add_index "cathegories_items", ["item_id"], name: "index_cathegories_items_on_item_id", using: :btree

  create_table "chat_messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checklists", force: :cascade do |t|
    t.integer  "proposal_id"
    t.boolean  "fifteen"
    t.integer  "width"
    t.integer  "height"
    t.integer  "length"
    t.string   "brand"
    t.string   "model"
    t.string   "serial"
    t.string   "damage"
    t.string   "work"
    t.boolean  "box"
    t.boolean  "cert"
    t.boolean  "labels"
    t.string   "notice"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "checklists", ["proposal_id"], name: "index_checklists_on_proposal_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.boolean  "default_city"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "address"
    t.string   "phone"
    t.integer  "country_id"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "point_id"
  end

  add_index "comments", ["point_id"], name: "index_comments_on_point_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "couriers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "delivery_service"
    t.integer  "city_id"
  end

  add_index "couriers", ["city_id"], name: "index_couriers_on_city_id", using: :btree
  add_index "couriers", ["email"], name: "index_couriers_on_email", unique: true, using: :btree
  add_index "couriers", ["reset_password_token"], name: "index_couriers_on_reset_password_token", unique: true, using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.float    "rate"
    t.integer  "country_id"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  add_index "currencies", ["country_id"], name: "index_currencies_on_country_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "file"
    t.integer  "item_id"
    t.integer  "proposal_id"
    t.string   "doc_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order_id"
  end

  add_index "documents", ["item_id"], name: "index_documents_on_item_id", using: :btree
  add_index "documents", ["order_id"], name: "index_documents_on_order_id", using: :btree
  add_index "documents", ["proposal_id"], name: "index_documents_on_proposal_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "session"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["item_id"], name: "index_favorites_on_item_id", using: :btree
  add_index "favorites", ["session"], name: "index_favorites_on_session", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "filials", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "address"
    t.integer  "phone",      limit: 8
    t.string   "work_hours"
    t.boolean  "main"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "filials", ["city_id"], name: "index_filials_on_city_id", using: :btree

  create_table "item_notices", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "text"
    t.boolean  "show"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_notices", ["item_id"], name: "index_item_notices_on_item_id", using: :btree

  create_table "item_views", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "session"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_views", ["item_id"], name: "index_item_views_on_item_id", using: :btree
  add_index "item_views", ["user_id"], name: "index_item_views_on_user_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "description"
    t.integer  "city_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "price"
    t.integer  "status_id"
    t.integer  "proposal_id"
    t.integer  "item_views_count"
    t.integer  "filial_id"
    t.string   "aasm_state"
    t.integer  "admin_user_id"
    t.boolean  "action",           default: true
    t.string   "stock_place"
  end

  add_index "items", ["admin_user_id"], name: "index_items_on_admin_user_id", using: :btree
  add_index "items", ["city_id"], name: "index_items_on_city_id", using: :btree
  add_index "items", ["filial_id"], name: "index_items_on_filial_id", using: :btree
  add_index "items", ["proposal_id"], name: "index_items_on_proposal_id", using: :btree
  add_index "items", ["status_id"], name: "index_items_on_status_id", using: :btree
  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "langs", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
    t.integer  "country_id"
  end

  add_index "langs", ["country_id"], name: "index_langs_on_country_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.string   "url"
    t.integer  "admin_user_id"
    t.string   "site"
    t.integer  "item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "links", ["admin_user_id"], name: "index_links_on_admin_user_id", using: :btree
  add_index "links", ["item_id"], name: "index_links_on_item_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.integer  "comment_id"
    t.integer  "point_id"
    t.integer  "user_id"
    t.binary   "bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "media", ["comment_id"], name: "index_media_on_comment_id", using: :btree
  add_index "media", ["point_id"], name: "index_media_on_point_id", using: :btree
  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "point_type"
  end

  add_index "news", ["point_id"], name: "index_news_on_point_id", using: :btree
  add_index "news", ["user_id"], name: "index_news_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "payment"
    t.string   "payment_type"
    t.string   "aasm_state"
    t.integer  "status_id"
    t.string   "delivery_type"
    t.string   "address"
    t.string   "mobile"
    t.integer  "user_id"
    t.integer  "city_id"
    t.boolean  "action"
    t.integer  "courier_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "admin_user_id"
    t.string   "track_number"
  end

  add_index "orders", ["admin_user_id"], name: "index_orders_on_admin_user_id", using: :btree
  add_index "orders", ["city_id"], name: "index_orders_on_city_id", using: :btree
  add_index "orders", ["courier_id"], name: "index_orders_on_courier_id", using: :btree
  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree
  add_index "orders", ["status_id"], name: "index_orders_on_status_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "image"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "proposal_id"
    t.integer  "position"
    t.string   "photo_type",  default: "user"
  end

  add_index "photos", ["item_id"], name: "index_photos_on_item_id", using: :btree
  add_index "photos", ["proposal_id"], name: "index_photos_on_proposal_id", using: :btree

  create_table "points", force: :cascade do |t|
    t.float    "lng"
    t.float    "lat"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",           precision: 6,                 null: false
    t.datetime "updated_at",           precision: 6,                 null: false
    t.integer  "user_id"
    t.integer  "rating",                             default: 0
    t.string   "point_type"
    t.boolean  "isFulltime",                         default: true
    t.boolean  "cardAccepted",                       default: false
    t.boolean  "beer",                               default: true
    t.boolean  "hard",                               default: true
    t.boolean  "elite",                              default: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at",   precision: 6
  end

  add_index "points", ["user_id"], name: "index_points_on_user_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.integer  "currency_id"
    t.integer  "item_id"
    t.integer  "value_kopecks",  default: 0,     null: false
    t.string   "value_currency", default: "RUB", null: false
    t.string   "price_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "show"
    t.boolean  "current"
    t.integer  "user_id"
  end

  add_index "prices", ["currency_id"], name: "index_prices_on_currency_id", using: :btree
  add_index "prices", ["item_id"], name: "index_prices_on_item_id", using: :btree
  add_index "prices", ["user_id"], name: "index_prices_on_user_id", using: :btree

  create_table "problems", force: :cascade do |t|
    t.text     "reason"
    t.integer  "item_id"
    t.integer  "proposal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "problems", ["item_id"], name: "index_problems_on_item_id", using: :btree
  add_index "problems", ["proposal_id"], name: "index_problems_on_proposal_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "age"
    t.string   "sex"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer  "cathegory_id"
    t.string   "name",                      null: false
    t.string   "control_type",              null: false
    t.text     "values",       default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "prefix"
    t.string   "postfix"
  end

  add_index "properties", ["cathegory_id"], name: "index_properties_on_cathegory_id", using: :btree

  create_table "property_values", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "item_id"
    t.string   "string_value"
    t.float    "float_value"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "multiselect_values", default: [],              array: true
  end

  add_index "property_values", ["item_id"], name: "index_property_values_on_item_id", using: :btree
  add_index "property_values", ["property_id"], name: "index_property_values_on_property_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status_id"
    t.integer  "city_id"
    t.float    "price"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "delivery_type"
    t.string   "address"
    t.string   "mobile"
    t.string   "aasm_state"
    t.integer  "admin_user_id"
    t.boolean  "action",            default: true
    t.integer  "courier_id"
    t.float    "recommended_price"
  end

  add_index "proposals", ["admin_user_id"], name: "index_proposals_on_admin_user_id", using: :btree
  add_index "proposals", ["city_id"], name: "index_proposals_on_city_id", using: :btree
  add_index "proposals", ["courier_id"], name: "index_proposals_on_courier_id", using: :btree
  add_index "proposals", ["status_id"], name: "index_proposals_on_status_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "rated_points", force: :cascade do |t|
    t.boolean  "direction"
    t.integer  "user_id"
    t.integer  "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rated_points", ["point_id"], name: "index_rated_points_on_point_id", using: :btree
  add_index "rated_points", ["user_id"], name: "index_rated_points_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "json"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id", using: :btree

  create_table "slides", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "text"
    t.string   "desktop_img"
    t.string   "tablet_img"
    t.string   "mobile_img"
    t.string   "href"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "position"
  end

  add_index "slides", ["city_id"], name: "index_slides_on_city_id", using: :btree
  add_index "slides", ["item_id"], name: "index_slides_on_item_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status_type"
    t.string   "code"
  end

  create_table "text_pages", force: :cascade do |t|
    t.string   "slug"
    t.text     "text"
    t.boolean  "draft",      default: true
    t.boolean  "system"
    t.string   "draft_key"
    t.string   "tags",       default: [],                array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "mobile"
  end

  add_index "text_pages", ["slug"], name: "index_text_pages_on_slug", using: :btree

  create_table "translations", force: :cascade do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "lang_id"
  end

  add_index "translations", ["lang_id"], name: "index_translations_on_lang_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin"
    t.datetime "created_at",             precision: 6,              null: false
    t.datetime "updated_at",             precision: 6,              null: false
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at",    precision: 6
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at",     precision: 6
    t.datetime "last_sign_in_at",        precision: 6
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at",  precision: 6
    t.datetime "invitation_sent_at",     precision: 6
    t.datetime "invitation_accepted_at", precision: 6
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                    default: 0
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cathegories_items", "cathegories"
  add_foreign_key "cathegories_items", "items"
  add_foreign_key "checklists", "proposals"
  add_foreign_key "couriers", "cities"
  add_foreign_key "documents", "items"
  add_foreign_key "documents", "orders"
  add_foreign_key "documents", "proposals"
  add_foreign_key "favorites", "items"
  add_foreign_key "favorites", "users"
  add_foreign_key "filials", "cities"
  add_foreign_key "item_notices", "items"
  add_foreign_key "item_views", "items"
  add_foreign_key "items", "cities"
  add_foreign_key "items", "statuses"
  add_foreign_key "links", "items"
  add_foreign_key "media", "comments"
  add_foreign_key "media", "points"
  add_foreign_key "media", "users"
  add_foreign_key "orders", "cities"
  add_foreign_key "orders", "couriers"
  add_foreign_key "orders", "items"
  add_foreign_key "orders", "statuses"
  add_foreign_key "photos", "items"
  add_foreign_key "photos", "proposals"
  add_foreign_key "points", "users"
  add_foreign_key "points", "users", name: "points_user_id_fkey"
  add_foreign_key "prices", "currencies"
  add_foreign_key "prices", "items"
  add_foreign_key "problems", "items"
  add_foreign_key "problems", "proposals"
  add_foreign_key "properties", "cathegories"
  add_foreign_key "property_values", "items"
  add_foreign_key "property_values", "properties"
  add_foreign_key "proposals", "cities"
  add_foreign_key "proposals", "couriers"
  add_foreign_key "proposals", "statuses"
  add_foreign_key "rated_points", "points"
  add_foreign_key "rated_points", "users"
  add_foreign_key "slides", "cities"
  add_foreign_key "slides", "items"
  add_foreign_key "translations", "langs"
end
