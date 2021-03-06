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

ActiveRecord::Schema.define(version: 20160515014411) do

  create_table "trade_hourly_stats", force: :cascade do |t|
    t.integer  "vendor_id",  limit: 4,   null: false, unsigned: true
    t.string   "trade_type", limit: 255
    t.datetime "hour"
    t.float    "avg_price",  limit: 24,  null: false, unsigned: true
  end

  add_index "trade_hourly_stats", ["vendor_id", "trade_type", "hour"], name: "additional_idx01", using: :btree

  create_table "trades", force: :cascade do |t|
    t.integer  "vendor_id",       limit: 4,   null: false, unsigned: true
    t.integer  "vendor_trade_id", limit: 4,                unsigned: true
    t.string   "trade_type",      limit: 255
    t.float    "price",           limit: 24,               unsigned: true
    t.float    "amount",          limit: 24,               unsigned: true
    t.datetime "executed_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "api",        limit: 255
    t.string   "url_board",  limit: 255
    t.string   "url_trade",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
