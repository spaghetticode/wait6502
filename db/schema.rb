# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100202121545) do

  create_table "auctions", :force => true do |t|
    t.integer  "hardware_id",                                         :null => false
    t.string   "ebay_site_id",                                        :null => false
    t.string   "currency_id",                                         :null => false
    t.string   "title",                                               :null => false
    t.string   "url",                                                 :null => false
    t.string   "image_url"
    t.string   "item_id",                                             :null => false
    t.string   "cosmetic_conditions",                                 :null => false
    t.string   "completeness",                                        :null => false
    t.decimal  "final_price",          :precision => 11, :scale => 2
    t.datetime "end_time",                                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "builtin_languages", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "builtin_storages", :force => true do |t|
    t.string   "storage_name_id",   :null => false
    t.string   "storage_format_id"
    t.string   "storage_size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builtin_storages_hardware", :id => false, :force => true do |t|
    t.integer "hardware_id"
    t.integer "builtin_storage_id"
  end

  create_table "co_cpu_names", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "co_cpu_types", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

  create_table "co_cpus", :force => true do |t|
    t.string   "co_cpu_name_id"
    t.string   "co_cpu_type_id"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cpu_family_id"
    t.text     "description"
  end

  create_table "co_cpus_hardware", :id => false, :force => true do |t|
    t.integer "hardware_id"
    t.integer "co_cpu_id"
  end

  create_table "countries", :id => false, :force => true do |t|
    t.string   "name",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
  end

  create_table "cpu_bits", :id => false, :force => true do |t|
    t.string "name", :null => false
  end

  create_table "cpu_families", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpu_names", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpus", :force => true do |t|
    t.string   "cpu_bit_id",      :null => false
    t.string   "cpu_family_id"
    t.integer  "manufacturer_id", :null => false
    t.string   "cpu_name_id",     :null => false
    t.string   "clock",           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "parent_cpu_id"
  end

  create_table "cpus_hardware", :id => false, :force => true do |t|
    t.integer "hardware_id"
    t.integer "cpu_id"
  end

  create_table "currencies", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebay_keywords", :force => true do |t|
    t.string   "name"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebay_sites", :id => false, :force => true do |t|
    t.string   "name",        :null => false
    t.string   "site_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency_id"
    t.string   "country_id"
  end

  create_table "hardware", :force => true do |t|
    t.string  "name",                :null => false
    t.string  "code"
    t.text    "notes"
    t.integer "manufacturer_id",     :null => false
    t.integer "production_start"
    t.integer "production_stop"
    t.string  "codename"
    t.text    "text_modes"
    t.text    "graphic_modes"
    t.text    "sound"
    t.string  "builtin_language_id"
    t.string  "ram"
    t.string  "vram"
    t.string  "rom"
    t.string  "hardware_category"
    t.string  "hardware_type_id",    :null => false
    t.text    "description"
    t.text    "trivia"
  end

  create_table "hardware_io_ports", :id => false, :force => true do |t|
    t.integer "hardware_id"
    t.integer "io_port_id"
  end

  create_table "hardware_operative_systems", :id => false, :force => true do |t|
    t.integer "hardware_id"
    t.integer "operative_system_id"
  end

  create_table "hardware_types", :id => false, :force => true do |t|
    t.string "name"
  end

  create_table "images", :force => true do |t|
    t.string   "original_filename"
    t.string   "title"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imageable_id",         :null => false
    t.string   "imageable_type"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "io_ports", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "connector"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "letters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name",              :null => false
    t.string   "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_update_at"
  end

  create_table "operative_systems", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_prices", :force => true do |t|
    t.string   "currency_id"
    t.string   "country_id"
    t.date     "date"
    t.decimal  "amount",            :precision => 11, :scale => 2
    t.integer  "purchaseable_id"
    t.string   "purchaseable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tainted"
  end

  create_table "storage_formats", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_names", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_sizes", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_request_at"
  end

end
