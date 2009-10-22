class CreateStorageNames < ActiveRecord::Migration
  def self.up
    create_table :storage_names, :id => false do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_names
  end
end
