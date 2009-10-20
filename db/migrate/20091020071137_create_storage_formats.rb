class CreateStorageFormats < ActiveRecord::Migration
  def self.up
    create_table :storage_formats, :id => false do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_formats
  end
end
