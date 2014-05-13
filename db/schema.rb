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

ActiveRecord::Schema.define(version: 20140513022056) do

  create_table "authentications", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "access_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", force: true do |t|
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_projects", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "project_id"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities_projects", force: true do |t|
    t.integer "project_id"
    t.integer "city_id"
  end

  create_table "contacts", force: true do |t|
    t.string   "address"
    t.string   "phone"
    t.string   "qq"
    t.string   "weixin"
    t.string   "weibo"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "title"
    t.text     "data"
    t.integer  "project_id"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funs", force: true do |t|
    t.integer "user_id"
    t.integer "interested_user_id"
  end

  create_table "investideas", force: true do |t|
    t.string   "coin_type"
    t.integer  "min"
    t.integer  "max"
    t.string   "industry"
    t.string   "idea"
    t.string   "give"
    t.integer  "investor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investments", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.integer  "money"
    t.integer  "money_require_id"
    t.integer  "investor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investor_audits", force: true do |t|
    t.integer  "investor_id"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investors", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "company"
    t.string   "title"
    t.text     "description"
    t.string   "investor_type"
    t.string   "card"
    t.string   "status",        default: "drafted"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logos", force: true do |t|
    t.integer  "project_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "priv"
    t.string   "role"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["user_id", "project_id"], name: "index_members_on_user_id_and_project_id", unique: true

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "project_id"
    t.boolean  "must_action"
    t.string   "status"
    t.string   "target_type"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_read"
  end

  create_table "money_requires", force: true do |t|
    t.integer  "money"
    t.integer  "share"
    t.text     "description"
    t.string   "status",      default: "ready"
    t.integer  "deadline"
    t.integer  "project_id"
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.boolean  "success"
  end

  create_table "person_requires", force: true do |t|
    t.string   "title"
    t.integer  "pay"
    t.integer  "stock"
    t.integer  "option"
    t.text     "description"
    t.integer  "project_id"
    t.boolean  "remote",      default: false
    t.boolean  "part",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "oneword"
    t.text     "description"
    t.string   "stage"
    t.string   "industry"
    t.string   "city"
    t.boolean  "published",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "team_story"
  end

  create_table "recommends", force: true do |t|
    t.integer  "project_id"
    t.text     "description"
    t.boolean  "deleted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "stars", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name"
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
