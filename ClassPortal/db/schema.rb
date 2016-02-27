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

ActiveRecord::Schema.define(version: 20160227003521) do

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_instructors", force: :cascade do |t|
    t.integer  "course_id",     limit: 4
    t.integer  "instructor_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "course_instructors", ["course_id"], name: "index_course_instructors_on_course_id", using: :btree
  add_index "course_instructors", ["instructor_id"], name: "index_course_instructors_on_instructor_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "Title",        limit: 255
    t.string   "Description",  limit: 255
    t.date     "Startdate"
    t.date     "Enddate"
    t.string   "Status",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "CourseNumber", limit: 30
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "course_id",  limit: 4
    t.string   "grade",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "inactive_requests", force: :cascade do |t|
    t.integer  "instructor_id", limit: 4
    t.integer  "course_id",     limit: 4
    t.string   "Status",        limit: 255, default: "Pending"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "inactive_requests", ["course_id"], name: "index_inactive_requests_on_course_id", using: :btree
  add_index "inactive_requests", ["instructor_id"], name: "index_inactive_requests_on_instructor_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body",            limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.boolean  "read",                          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "references", force: :cascade do |t|
    t.string   "description",         limit: 255
    t.string   "string_file_name",    limit: 255
    t.string   "string_content_type", limit: 255
    t.integer  "string_file_size",    limit: 4
    t.datetime "string_updated_at"
    t.integer  "course_id",           limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "attachment",          limit: 255
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.integer  "course_id",  limit: 4
    t.string   "Status",     limit: 255, default: "Pending"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "requests", ["course_id"], name: "index_requests_on_course_id", using: :btree
  add_index "requests", ["student_id"], name: "index_requests_on_student_id", using: :btree

  create_table "subscribes", force: :cascade do |t|
    t.string   "user",       limit: 255
    t.string   "course",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "super",                              default: false
    t.boolean  "admin",                              default: false
    t.boolean  "instructor",                         default: false
    t.boolean  "student",                            default: true
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "course_instructors", "courses"
  add_foreign_key "course_instructors", "users", column: "instructor_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "inactive_requests", "courses"
  add_foreign_key "inactive_requests", "users", column: "instructor_id"
  add_foreign_key "requests", "courses"
  add_foreign_key "requests", "users", column: "student_id"
end
