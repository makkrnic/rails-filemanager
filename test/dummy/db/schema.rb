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

ActiveRecord::Schema.define(version: 20140729130927) do

  create_table "owners", force: true do |t|
    t.string   "name"
    t.integer  "max_total_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_filemanager_filemanager_files", force: true do |t|
    t.string   "name"
    t.integer  "parent_directory_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "ancestry"
    t.string   "owner_type"
  end

  add_index "rails_filemanager_filemanager_files", ["ancestry"], name: "index_rails_filemanager_filemanager_files_on_ancestry"

end
