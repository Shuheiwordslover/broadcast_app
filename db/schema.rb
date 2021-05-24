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

ActiveRecord::Schema.define(version: 20210524021405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "file_name"
    t.string   "URL"
    t.integer  "mail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "file_id"
  end

  create_table "broadcasts", force: :cascade do |t|
    t.string   "email"
    t.string   "column1"
    t.string   "column2"
    t.string   "column3"
    t.string   "column4"
    t.string   "column5"
    t.string   "column6"
    t.string   "column7"
    t.string   "column8"
    t.string   "column9"
    t.string   "column10"
    t.text     "body"
    t.text     "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "mailinfos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "mail_id"
    t.text     "body"
    t.text     "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mymails", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address"
    t.string   "domain"
    t.string   "user_name"
    t.string   "password"
    t.string   "authentication"
    t.boolean  "enable_starttls_auto"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "login_id"
    t.string   "password"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "password_digest"
    t.datetime "deleted_at"
    t.boolean  "admin",                default: false
    t.string   "address",              default: ""
    t.integer  "port",                 default: 25
    t.string   "domain",               default: ""
    t.string   "user_name",            default: ""
    t.string   "smtp_password",        default: ""
    t.string   "authentication",       default: ""
    t.boolean  "enable_starttls_auto", default: true
    t.string   "avatar"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree

end
