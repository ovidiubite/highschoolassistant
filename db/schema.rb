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

ActiveRecord::Schema.define(version: 20160514070752) do

  create_table "admission_results", force: :cascade do |t|
    t.integer "admission_rate"
    t.integer "evaluation_rate"
    t.integer "graduation_rate"
    t.integer "grade_math"
    t.integer "grade_romana"
    t.integer "grade_native"
    t.string  "assigned_school"
    t.string  "section"
    t.string  "county"
  end

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluation_results", force: :cascade do |t|
    t.string  "county"
    t.integer "evaluation_rate"
    t.integer "grade_math"
    t.integer "grade_romana"
    t.integer "grade_native"
    t.string  "school"
  end

  create_table "highschool_details", force: :cascade do |t|
    t.integer  "students_number"
    t.integer  "last_rate"
    t.integer  "year"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "section_id"
    t.integer  "highschool_id"
  end

  add_index "highschool_details", ["highschool_id"], name: "index_highschool_details_on_highschool_id"
  add_index "highschool_details", ["section_id"], name: "index_highschool_details_on_section_id"

  create_table "highschools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "county_id"
  end

  add_index "highschools", ["county_id"], name: "index_highschools_on_county_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
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
    t.integer  "role_id"
    t.string   "school"
    t.string   "city"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
