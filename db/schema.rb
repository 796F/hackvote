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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140514181814) do

  create_table "hackdays", :force => true do |t|
    t.string   "title",      :null => false
    t.date     "day"
    t.string   "img_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hacks", :force => true do |t|
    t.string   "title"
    t.integer  "votes",       :default => 0
    t.string   "hack_url"
    t.string   "img_url"
    t.string   "owner"
    t.text     "description"
    t.integer  "hackday_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "hacks", ["hackday_id"], :name => "index_hacks_on_hackday_id"

end
