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

ActiveRecord::Schema.define(version: 20170603195812) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "binaries", force: :cascade do |t|
    t.string   "name"
    t.string   "extension"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "folder_id"
    t.string   "data_url"
    t.integer  "status",     default: 0
    t.index ["folder_id"], name: "index_binaries_on_folder_id", using: :btree
  end

  create_table "binary_downloads", force: :cascade do |t|
    t.integer  "binary_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["binary_id"], name: "index_binary_downloads_on_binary_id", using: :btree
    t.index ["user_id"], name: "index_binary_downloads_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "binary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["binary_id"], name: "index_comments_on_binary_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.string   "route"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "permission", default: 0
    t.string   "slug"
    t.integer  "status",     default: 0
    t.index ["folder_id"], name: "index_folders_on_folder_id", using: :btree
    t.index ["slug"], name: "index_folders_on_slug", using: :btree
    t.index ["user_id"], name: "index_folders_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "shared_folders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_shared_folders_on_folder_id", using: :btree
    t.index ["user_id"], name: "index_shared_folders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "fb_id"
    t.integer  "status",            default: 0
    t.string   "email"
    t.string   "phone"
    t.string   "token"
    t.datetime "created_at",                                                                                       null: false
    t.datetime "updated_at",                                                                                       null: false
    t.string   "password_digest"
    t.integer  "role",              default: 0
    t.string   "verification_code"

    t.string   "avatar_url",        default: "https://robohash.org/omnisquiavoluptatem.png?size=300x300&set=set1"
  end

  add_foreign_key "binaries", "folders"
  add_foreign_key "binary_downloads", "binaries"
  add_foreign_key "binary_downloads", "users"
  add_foreign_key "comments", "binaries"
  add_foreign_key "comments", "users"
  add_foreign_key "folders", "folders"
  add_foreign_key "folders", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "shared_folders", "folders"
  add_foreign_key "shared_folders", "users"
end
