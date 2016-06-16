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

ActiveRecord::Schema.define(version: 20160616174943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

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

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bookmarks", ["subcategory_id"], name: "index_bookmarks_on_subcategory_id", using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["talk_id"], name: "index_comments_on_talk_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.integer  "subcategory_id"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "image"
  end

  add_index "images", ["category_id"], name: "index_images_on_category_id", using: :btree
  add_index "images", ["subcategory_id"], name: "index_images_on_subcategory_id", using: :btree

  create_table "ips", force: :cascade do |t|
    t.string   "ip"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "pin"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recent_checks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "recent_checks", ["subcategory_id"], name: "index_recent_checks_on_subcategory_id", using: :btree
  add_index "recent_checks", ["user_id"], name: "index_recent_checks_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "reviews", ["subcategory_id"], name: "index_reviews_on_subcategory_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "socialauths", force: :cascade do |t|
    t.string   "provider_id"
    t.string   "provider_name"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "socialauths", ["user_id"], name: "index_socialauths_on_user_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string   "title"
    t.string   "profile_link"
    t.string   "contact"
    t.text     "description"
    t.string   "timing"
    t.string   "street_address"
    t.string   "city"
    t.string   "pin"
    t.string   "state"
    t.string   "page_url"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "email"
    t.string   "tag_line"
    t.string   "rating"
    t.string   "review"
    t.integer  "user_id"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree
  add_index "subcategories", ["user_id"], name: "index_subcategories_on_user_id", using: :btree

  create_table "talk_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "talk_users", ["talk_id"], name: "index_talk_users_on_talk_id", using: :btree
  add_index "talk_users", ["user_id"], name: "index_talk_users_on_user_id", using: :btree

  create_table "talks", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_comments", force: :cascade do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "admin_id"
  end

  add_index "ticket_comments", ["ticket_id"], name: "index_ticket_comments_on_ticket_id", using: :btree
  add_index "ticket_comments", ["user_id"], name: "index_ticket_comments_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subcategory_id"
  end

  add_index "tickets", ["subcategory_id"], name: "index_tickets_on_subcategory_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "gender"
    t.string   "password_digest"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "contact"
    t.string   "confirmation_token"
    t.boolean  "is_confirm"
    t.string   "forget_password_token"
    t.string   "image"
    t.boolean  "is_business"
    t.text     "about"
  end

  add_foreign_key "bookmarks", "subcategories"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "talks"
  add_foreign_key "comments", "users"
  add_foreign_key "images", "categories"
  add_foreign_key "images", "subcategories"
  add_foreign_key "recent_checks", "subcategories"
  add_foreign_key "recent_checks", "users"
  add_foreign_key "reviews", "subcategories"
  add_foreign_key "reviews", "users"
  add_foreign_key "socialauths", "users"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "subcategories", "users"
  add_foreign_key "talk_users", "talks"
  add_foreign_key "talk_users", "users"
  add_foreign_key "ticket_comments", "tickets"
  add_foreign_key "ticket_comments", "users"
  add_foreign_key "tickets", "subcategories"
  add_foreign_key "tickets", "users"
end
