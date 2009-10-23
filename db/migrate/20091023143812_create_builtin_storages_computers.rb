class CreateBuiltinStoragesComputers < ActiveRecord::Migration
  def self.up
    create_table :builtin_storages_computers, :id => false do |t|
      t.integer :computer_id, :builtin_storage_id
    end
  end

  def self.down
    drop_table :builtin_storages_computers
  end
end
