class AddManufacturersDescription < ActiveRecord::Migration
  def self.up
    add_column :manufacturers, :description, :text
  end

  def self.down
    remove_column :manufacturers, :description
  end
end
