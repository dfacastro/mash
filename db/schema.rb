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

ActiveRecord::Schema.define(:version => 20110727143029) do

  create_table "musics", :force => true do |t|
    t.string   "author"
    t.text     "description"
    t.boolean  "downloadable"
    t.string   "filename"
    t.integer  "length"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "average",       :precision => 8, :scale => 2
    t.integer  "total_ratings"
    t.integer  "hits",                                        :default => 0
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "music_id"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "name"
    t.date     "birthdate"
    t.string   "city"
    t.string   "country"
    t.string   "occupation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "confirmation_code"
    t.boolean  "confirmed"
  end

end
