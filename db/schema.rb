# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_13_083338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendance_details", force: :cascade do |t|
    t.bigint "attendance_id", null: false
    t.bigint "order_id", null: false
    t.bigint "work_id", null: false
    t.string "work_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "work_content"
    t.index ["attendance_id"], name: "index_attendance_details_on_attendance_id"
    t.index ["order_id"], name: "index_attendance_details_on_order_id"
    t.index ["work_id"], name: "index_attendance_details_on_work_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "work_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "base_date"
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "business_calendars", force: :cascade do |t|
    t.bigint "corporation_id", null: false
    t.date "date"
    t.string "proparties"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["corporation_id"], name: "index_business_calendars_on_corporation_id"
  end

  create_table "corporations", force: :cascade do |t|
    t.string "name"
    t.integer "time_unit"
    t.integer "time_limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "corporation_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["corporation_id"], name: "index_departments_on_corporation_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "department_id", null: false
    t.string "employee_code", null: false
    t.string "user_code", null: false
    t.string "name", null: false
    t.string "kana", null: false
    t.string "proparties", default: "3", null: false
    t.boolean "invalid_flag", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "corporation_id", null: false
    t.string "code"
    t.string "name"
    t.boolean "paid_digestion_flg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "time_flg"
    t.integer "rest_flg"
    t.date "expiration_date"
    t.index ["corporation_id"], name: "index_orders_on_corporation_id"
  end

  create_table "pattern_details", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "work_id", null: false
    t.bigint "pattern_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "work_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_pattern_details_on_order_id"
    t.index ["pattern_id"], name: "index_pattern_details_on_pattern_id"
    t.index ["work_id"], name: "index_pattern_details_on_work_id"
  end

  create_table "patterns", force: :cascade do |t|
    t.string "pattern_name"
    t.date "base_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "work_content"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "default_flg"
    t.index ["employee_id"], name: "index_patterns_on_employee_id"
  end

  create_table "works", force: :cascade do |t|
    t.bigint "corporation_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["corporation_id"], name: "index_works_on_corporation_id"
  end

  add_foreign_key "attendance_details", "attendances"
  add_foreign_key "attendance_details", "orders"
  add_foreign_key "attendance_details", "works"
  add_foreign_key "attendances", "employees"
  add_foreign_key "business_calendars", "corporations"
  add_foreign_key "departments", "corporations"
  add_foreign_key "employees", "departments"
  add_foreign_key "orders", "corporations"
  add_foreign_key "pattern_details", "orders"
  add_foreign_key "pattern_details", "patterns"
  add_foreign_key "pattern_details", "works"
  add_foreign_key "patterns", "employees"
  add_foreign_key "works", "corporations"
end
