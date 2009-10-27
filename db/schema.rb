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

ActiveRecord::Schema.define(:version => 20091027155025) do

  create_table "builtin_languages", :id => false, :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builtin_storages", :force => true do |t|
    t.string   "storage_name_id",   :null => false
    t.string   "storage_format_id"
    t.string   "storage_size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "builtin_storages_computers", :id => false, :force => true do |t|
    t.integer "computer_id"
    t.integer "builtin_storage_id"
  end

  create_table "builtin_storages_peripherals", :id => false, :force => true do |t|
    t.integer "peripheral_id"
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
  end

  create_table "co_cpus_computers", :id => false, :force => true do |t|
    t.integer "computer_id"
    t.integer "co_cpu_id"
  end

  create_table "computer_types", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "computers_cpus", :id => false, :force => true do |t|
    t.integer "computer_id"
    t.integer "cpu_id"
  end

  create_table "computers_io_ports", :id => false, :force => true do |t|
    t.integer "computer_id"
    t.integer "io_port_id"
  end

  create_table "computers_operative_systems", :id => false, :force => true do |t|
    t.integer "computer_id"
    t.integer "operative_system_id"
  end

  create_table "countries", :id => false, :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "clock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cpus_peripherals", :id => false, :force => true do |t|
    t.integer "peripheral_id"
    t.integer "cpu_id"
  end

  create_table "currencies", :force => true do |t|
    t.string   "code"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hardware", :force => true do |t|
    t.string  "type",                :null => false
    t.string  "name",                :null => false
    t.string  "code"
    t.text    "notes"
    t.integer "manufacturer_id",     :null => false
    t.integer "production_start"
    t.integer "production_stop"
    t.string  "computer_type_id"
    t.string  "codename"
    t.text    "text_modes"
    t.text    "graphic_modes"
    t.text    "sound"
    t.string  "builtin_language_id"
    t.string  "ram"
    t.string  "vram"
    t.string  "rom"
    t.string  "peripheral_type_id"
  end

  create_table "io_ports", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "connector"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "io_ports_peripherals", :id => false, :force => true do |t|
    t.integer "peripheral_id"
    t.integer "io_port_id"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operative_systems", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "original_prices", :force => true do |t|
    t.integer  "currency_id"
    t.string   "country_id"
    t.datetime "date"
    t.string   "amount"
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "peripheral_types", :id => false, :force => true do |t|
    t.string "name", :null => false
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
  end

end
