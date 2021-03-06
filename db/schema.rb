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

ActiveRecord::Schema.define(version: 20131217103656) do

  create_table "keys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "keyid"
    t.text     "raw"
  end

  create_table "uids", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "key_id"
    t.string   "email"
    t.string   "name"
    t.string   "secret"
    t.boolean  "revoked",           default: false, null: false
    t.boolean  "checked",           default: false, null: false
    t.integer  "user_id"
    t.string   "secret_key"
    t.string   "salt"
    t.string   "hashed_passphrase"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
