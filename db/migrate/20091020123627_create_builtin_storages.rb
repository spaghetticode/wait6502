class CreateBuiltinStorages < ActiveRecord::Migration
  def self.up
    create_table :builtin_storages do |t|
      t.string :storage_name_id, :null => false
      t.string :storage_format_id
      t.string :storage_size_id

      t.timestamps
    end
  end

  def self.down
    drop_table :builtin_storages
  end
end
