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

ActiveRecord::Schema.define(version: 20160630074438) do

  create_table "associated_roles", force: :cascade do |t|
    t.integer  "object_id",   limit: 4
    t.string   "object_type", limit: 255
    t.integer  "role_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associated_roles", ["object_id", "object_type"], name: "index_associated_roles_on_object_id_and_object_type", using: :btree
  add_index "associated_roles", ["role_id"], name: "fk_rails_bf722eff23", using: :btree

  create_table "competition_details", force: :cascade do |t|
    t.string   "brand_name",  limit: 255
    t.string   "sale",        limit: 255
    t.integer  "promoters",   limit: 4
    t.boolean  "is_sis"
    t.boolean  "is_gsb"
    t.integer  "retailer_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "volume",      limit: 4
  end

  add_index "competition_details", ["retailer_id"], name: "fk_rails_3a1af799b7", using: :btree

  create_table "designations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "focus_models", force: :cascade do |t|
    t.string   "target_model_name", limit: 255
    t.integer  "sale",              limit: 4
    t.integer  "target_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "focus_models", ["target_id"], name: "fk_rails_79e6e37d20", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "lat",         limit: 255
    t.string   "lng",         limit: 255
    t.string   "image",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "object_type", limit: 255
    t.integer  "object_id",   limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
    t.text     "location",    limit: 65535
    t.integer  "object_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type", limit: 255
  end

  add_index "locations", ["object_id"], name: "fk_rails_adf24266a9", using: :btree

  create_table "models", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "module_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id",         limit: 4
    t.integer  "module_group_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "permissions", ["module_group_id"], name: "fk_rails_84983d6609", using: :btree
  add_index "permissions", ["role_id"], name: "fk_rails_93c739e1a2", using: :btree

  create_table "permit_roles", force: :cascade do |t|
    t.integer  "parent_role", limit: 4
    t.integer  "child_role",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "permit_roles", ["child_role"], name: "fk_rails_6978088a04", using: :btree
  add_index "permit_roles", ["parent_role"], name: "fk_rails_19ec78ab19", using: :btree

  create_table "retailers", force: :cascade do |t|
    t.string   "retailer_name",              limit: 255
    t.string   "retailer_code",              limit: 255
    t.text     "address",                    limit: 65535
    t.string   "landmark",                   limit: 255
    t.float    "store_area",                 limit: 24
    t.integer  "store_monthly_sales_volume", limit: 4
    t.string   "store_monthly_sales_value",  limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "imei",                       limit: 255
    t.string   "state",                      limit: 255
    t.string   "city",                       limit: 255
    t.string   "mum",                        limit: 255
    t.string   "retailer_phone",             limit: 255
    t.integer  "user_id",                    limit: 4
    t.string   "location_code",              limit: 255
    t.string   "tmpCode",                    limit: 255
    t.integer  "tmpCount",                   limit: 4
  end

  add_index "retailers", ["user_id"], name: "fk_rails_3c8396c767", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sales_beats", force: :cascade do |t|
    t.string   "mum",               limit: 255
    t.string   "rds",               limit: 255
    t.string   "date",              limit: 255
    t.string   "retailer_code",     limit: 255
    t.integer  "stock_count",       limit: 4
    t.integer  "is_sis_maintained", limit: 4
    t.integer  "is_gsb_maintained", limit: 4
    t.integer  "gcs_present",       limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "imei",              limit: 255
    t.boolean  "payment_issue"
    t.integer  "user_id",           limit: 4
    t.string   "location_code",     limit: 255
  end

  add_index "sales_beats", ["user_id"], name: "fk_rails_1536132b39", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "mod_name",    limit: 255
    t.string   "count",       limit: 255
    t.string   "object_type", limit: 255
    t.integer  "object_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: :cascade do |t|
    t.string   "mum",            limit: 255
    t.string   "rds",            limit: 255
    t.string   "fos",            limit: 255
    t.string   "value_target",   limit: 255
    t.integer  "volume_target",  limit: 4
    t.text     "plan_remarks",   limit: 65535
    t.text     "review_remarks", limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "date",           limit: 255
    t.string   "imei",           limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "location_code",  limit: 255
  end

  add_index "targets", ["user_id"], name: "fk_rails_00291dd9f3", using: :btree

  create_table "user_activities", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "user_type",    limit: 255
    t.text     "message",      limit: 65535
    t.string   "activty_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_activities", ["user_id"], name: "fk_rails_56e545161c", using: :btree

  create_table "user_parents", force: :cascade do |t|
    t.integer "parent_id", limit: 4
    t.integer "child_id",  limit: 4
  end

  add_index "user_parents", ["child_id"], name: "fk_rails_5a18872ecb", using: :btree
  add_index "user_parents", ["parent_id"], name: "fk_rails_992d549353", using: :btree

  create_table "user_reporting_managers", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.integer  "reporting_manager_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "user_reporting_managers", ["reporting_manager_id"], name: "fk_rails_a1d569afb4", using: :btree
  add_index "user_reporting_managers", ["user_id"], name: "fk_rails_b834253637", using: :btree

  create_table "user_states", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "state_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type",  limit: 255
  end

  add_index "user_states", ["state_id"], name: "fk_rails_d6f793da8d", using: :btree
  add_index "user_states", ["user_id"], name: "fk_rails_308d74266a", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "email",              limit: 255,             null: false
    t.string   "encrypted_password", limit: 128,             null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,             null: false
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "mobile_number",      limit: 255
    t.string   "office_number",      limit: 255
    t.string   "landline_number",    limit: 255
    t.string   "profile_path",       limit: 255
    t.integer  "status",             limit: 4,   default: 1
    t.string   "account",            limit: 255
    t.datetime "last_login_time"
    t.datetime "last_logout_time"
    t.datetime "token_expiry"
    t.string   "location_code",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "zsales", force: :cascade do |t|
    t.string   "retailer_name",     limit: 255
    t.string   "retailer_code",     limit: 255
    t.string   "sales_channel",     limit: 255
    t.string   "contact_person",    limit: 255
    t.string   "state",             limit: 255
    t.string   "city",              limit: 255
    t.string   "pincode",           limit: 255
    t.string   "tin_number",        limit: 255
    t.string   "mobile_number",     limit: 255
    t.string   "status",            limit: 255,   default: "Active"
    t.string   "is_rsp_on_counter", limit: 255
    t.string   "counter_size",      limit: 255
    t.string   "nd",                limit: 255
    t.string   "lfr_chain",         limit: 255
    t.text     "address",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_code",     limit: 255
  end

  add_index "zsales", ["location_code"], name: "index_zsales_on_location_code", using: :btree

  create_table "zsales_activities", force: :cascade do |t|
    t.string   "location_code",        limit: 255
    t.string   "location_type",        limit: 255
    t.string   "person_name",          limit: 255
    t.string   "parent_location_code", limit: 255
    t.string   "email",                limit: 255
    t.string   "mobile_number",        limit: 255
    t.string   "employee_code",        limit: 255
    t.string   "last_updated_on",      limit: 255
    t.string   "status",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zusers", force: :cascade do |t|
    t.string   "location_code",        limit: 255
    t.string   "location_type",        limit: 255
    t.string   "person_name",          limit: 255
    t.string   "parent_location_code", limit: 255
    t.string   "email",                limit: 255
    t.string   "mobile_number",        limit: 255
    t.string   "employee_code",        limit: 255
    t.datetime "last_updated_on"
    t.integer  "status",               limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
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
  add_foreign_key "user_parents", "roles", column: "child_id"
  add_foreign_key "user_parents", "roles", column: "parent_id"
  add_foreign_key "user_reporting_managers", "users"
  add_foreign_key "user_reporting_managers", "users", column: "reporting_manager_id"
  add_foreign_key "user_states", "states"
  add_foreign_key "user_states", "users"
end
