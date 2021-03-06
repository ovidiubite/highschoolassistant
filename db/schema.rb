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

ActiveRecord::Schema.define(version: 20160624143513) do

  create_table "admission_results", force: :cascade do |t|
    t.string  "admission_rate"
    t.string  "evaluation_rate"
    t.string  "graduation_rate"
    t.string  "grade_math"
    t.string  "grade_romana"
    t.string  "grade_native"
    t.string  "assigned_school"
    t.integer "year"
    t.integer "county_id"
    t.integer "section_id"
    t.integer "highschool_detail_id"
    t.integer "position"
  end

  add_index "admission_results", ["county_id"], name: "index_admission_results_on_county_id"
  add_index "admission_results", ["highschool_detail_id"], name: "index_admission_results_on_highschool_detail_id"
  add_index "admission_results", ["section_id"], name: "index_admission_results_on_section_id"

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "alias"
  end

  create_table "evaluation_results", force: :cascade do |t|
    t.string  "evaluation_rate"
    t.integer "grade_math"
    t.integer "grade_romana"
    t.integer "grade_native"
    t.string  "school"
    t.integer "county_id"
    t.integer "year"
    t.integer "position"
  end

  add_index "evaluation_results", ["county_id"], name: "index_evaluation_results_on_county_id"

  create_table "highschool_details", force: :cascade do |t|
    t.integer  "students_number"
    t.string   "last_rate"
    t.integer  "year"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "section_id"
    t.integer  "highschool_id"
    t.string   "first_rate"
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

  create_table "results", force: :cascade do |t|
    t.string   "percentage"
    t.string   "overall_grade"
    t.string   "evaluation_rate"
    t.string   "graduation_rate"
    t.date     "date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "highschool_detail_id"
    t.integer  "user_id"
  end

  add_index "results", ["highschool_detail_id"], name: "index_results_on_highschool_detail_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

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
    t.integer  "county_id"
    t.string   "overall_grade"
    t.string   "evaluation_rate"
  end

  add_index "users", ["county_id"], name: "index_users_on_county_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
