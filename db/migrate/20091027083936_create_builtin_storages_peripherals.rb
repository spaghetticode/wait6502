class CreateBuiltinStoragesPeripherals < ActiveRecord::Migration
  def self.up
    create_table :builtin_storages_peripherals, :id => false do |t|
      t.integer :peripheral_id, :builtin_storage_id
    end
  end

  def self.down
    drop_table :builtin_storages_peripherals
  end
end
