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

ActiveRecord::Schema.define(:version => 20110811053858) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.decimal  "lat",         :precision => 10, :scale => 8
    t.decimal  "lng",         :precision => 10, :scale => 8
    t.text     "description"
    t.string   "area_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id",   :default => 0
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_numbers", :force => true do |t|
    t.string   "number"
    t.string   "type"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "area_id"
    t.string   "address"
    t.text     "description"
    t.string   "url"
    t.decimal  "lat",         :precision => 10, :scale => 8
    t.decimal  "lng",         :precision => 10, :scale => 8
    t.decimal  "rating",      :precision => 3,  :scale => 2, :default => 0.0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
