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

ActiveRecord::Schema.define(version: 20160715120214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "associated_roles", force: :cascade do |t|
    t.integer  "object_id"
    t.string   "object_type"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associated_roles", ["object_id", "object_type"], name: "index_associated_roles_on_object_id_and_object_type", using: :btree

  create_table "competition_details", force: :cascade do |t|
    t.string   "brand_name"
    t.string   "sale"
    t.integer  "promoters"
    t.boolean  "is_sis"
    t.boolean  "is_gsb"
    t.integer  "retailer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "volume"
  end

  create_table "designations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "focus_models", force: :cascade do |t|
    t.string   "target_model_name"
    t.integer  "sale"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.string   "lat"
    t.string   "lng"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "object_type"
    t.integer  "object_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.text     "location"
    t.integer  "object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type"
  end

  create_table "models", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "module_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "module_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "permit_roles", force: :cascade do |t|
    t.integer  "parent_role"
    t.integer  "child_role"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "retailers", force: :cascade do |t|
    t.string   "retailer_name"
    t.string   "retailer_code"
    t.text     "address"
    t.string   "landmark"
    t.float    "store_area"
    t.integer  "store_monthly_sales_volume"
    t.string   "store_monthly_sales_value"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "imei"
    t.string   "state"
    t.string   "city"
    t.string   "mum"
    t.string   "retailer_phone"
    t.integer  "user_id"
    t.string   "location_code"
    t.string   "tmpcode"
    t.integer  "tmpcount"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_beats", force: :cascade do |t|
    t.string   "mum"
    t.string   "rds"
    t.string   "date"
    t.string   "retailer_code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "imei"
    t.integer  "is_sis_maintained"
    t.integer  "is_gsb_maintained"
    t.integer  "gcs_present"
    t.integer  "stock_count"
    t.boolean  "payment_issue"
    t.integer  "user_id"
    t.string   "location_code"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "mod_name"
    t.string   "object_type"
    t.integer  "object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "count"
  end

  create_table "targets", force: :cascade do |t|
    t.string   "mum"
    t.string   "rds"
    t.string   "fos"
    t.string   "value_target"
    t.integer  "volume_target"
    t.text     "plan_remarks"
    t.text     "review_remarks"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "date"
    t.string   "imei"
    t.integer  "user_id"
    t.string   "location_code"
  end

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "message"
    t.string   "activty_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_reporting_managers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reporting_manager_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "user_states", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "email",                                      null: false
    t.string   "encrypted_password", limit: 128,             null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "office_number"
    t.string   "landline_number"
    t.string   "profile_path"
    t.integer  "status",                         default: 1
    t.string   "account"
    t.datetime "last_login_time"
    t.datetime "last_logout_time"
    t.datetime "token_expiry"
    t.string   "location_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "zsales", force: :cascade do |t|
    t.string   "retailer_name"
    t.string   "retailer_code"
    t.string   "sales_channel"
    t.string   "contact_person"
    t.string   "state"
    t.string   "city"
    t.string   "pincode"
    t.string   "tin_number"
    t.string   "mobile_number"
    t.string   "status",            default: "Active"
    t.string   "is_rsp_on_counter"
    t.string   "counter_size"
    t.string   "nd"
    t.string   "lfr_chain"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_code"
  end

  add_index "zsales", ["location_code"], name: "index_zsales_on_location_code", using: :btree

  create_table "zsales_activities", force: :cascade do |t|
    t.string   "location_code"
    t.string   "location_type"
    t.string   "person_name"
    t.string   "parent_location_code"
    t.string   "email"
    t.string   "mobile_number"
    t.string   "employee_code"
    t.string   "last_updated_on"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zusers", force: :cascade do |t|
    t.string   "location_code"
    t.string   "location_type"
    t.string   "person_name"
    t.string   "parent_location_code"
    t.string   "email"
    t.string   "mobile_number"
    t.string   "employee_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_updated_on"
    t.integer  "status"
  end

  add_index "zusers", ["location_code"], name: "index_zusers_on_location_code", using: :btree

  add_foreign_key "associated_roles", "roles"
  add_foreign_key "associated_roles", "users", column: "object_id"
  add_foreign_key "competition_details", "retailers"
  add_foreign_key "focus_models", "targets"
  add_foreign_key "permissions", "module_groups"
  add_foreign_key "permissions", "roles"
  add_foreign_key "permit_roles", "roles", column: "child_role"
  add_foreign_key "permit_roles", "roles", column: "parent_role"
  add_foreign_key "retailers", "users"
  add_foreign_key "sales_beats", "users"
  add_foreign_key "targets", "users"
  add_foreign_key "user_activities", "users"
  add_foreign_key "user_reporting_managers", "users"
  add_foreign_key "user_reporting_managers", "users", column: "reporting_manager_id"
  add_foreign_key "user_states", "states"
  add_foreign_key "user_states", "users"
end
