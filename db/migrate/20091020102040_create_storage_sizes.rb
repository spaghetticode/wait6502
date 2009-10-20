class CreateStorageSizes < ActiveRecord::Migration
  def self.up
    create_table :storage_sizes, :id => false do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_sizes
  end
end
