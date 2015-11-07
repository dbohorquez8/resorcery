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

ActiveRecord::Schema.define(version: 20151107085602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "allocations", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.hstore   "metadata",          default: {}, null: false
    t.integer  "workspace_id"
    t.integer  "resource_id"
    t.integer  "resource_group_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "allocations", ["start_date", "end_date"], name: "index_allocations_on_start_date_and_end_date", using: :btree
  add_index "allocations", ["workspace_id", "resource_id", "resource_group_id"], name: "workspace_resource_and_group", using: :btree

  create_table "resource_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "workspace_id"
    t.hstore   "metadata",     default: {}, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "resource_groups", ["workspace_id"], name: "index_resource_groups_on_workspace_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.integer  "workspace_id"
    t.hstore   "metadata",     default: {}, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "resources", ["workspace_id"], name: "index_resources_on_workspace_id", using: :btree

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workspaces", force: :cascade do |t|
    t.string   "name"
    t.hstore   "metadata",   default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
  end

  add_index "workspaces", ["user_id"], name: "index_workspaces_on_user_id", using: :btree

end
