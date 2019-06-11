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

ActiveRecord::Schema.define(version: 20190604133722) do

  create_table "attendances", force: :cascade do |t|
    t.string "sperior", default: ""
    t.date "worked_on"
    t.datetime "start_at"
    t.datetime "finished_at"
    t.datetime "new_start"
    t.datetime "new_finish"
    t.datetime "plans"
    t.boolean "box"
    t.string "note"
    t.string "year"
    t.string "month"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "first_day"
    t.string "result", default: ""
    t.datetime "center_s"
    t.datetime "center_f"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "basename"
    t.integer "baseno"
    t.string "attend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.integer "one_month_num", default: 0
    t.integer "edit_num", default: 0
    t.integer "over_time_num", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "send2s", force: :cascade do |t|
    t.string "sperior"
    t.date "worked_on"
    t.string "time"
    t.string "overtime"
    t.datetime "new_finish"
    t.boolean "box", default: false
    t.string "note"
    t.string "answer"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_send2s_on_user_id"
  end

  create_table "sends", force: :cascade do |t|
    t.string "superior"
    t.string "month"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "conf"
    t.datetime "tm"
    t.boolean "box"
    t.index ["user_id"], name: "index_sends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "affiliation"
    t.integer "employee_number"
    t.string "uid"
    t.datetime "basic_work_time", default: "2019-04-30 23:00:00"
    t.datetime "designated_work_start_time", default: "2019-04-30 23:00:00"
    t.datetime "designated_work_end_time", default: "2019-05-01 07:00:00"
    t.boolean "superior", default: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
