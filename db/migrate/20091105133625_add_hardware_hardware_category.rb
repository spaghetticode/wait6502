class AddHardwareHardwareCategory < ActiveRecord::Migration
  def self.up
    add_column :hardware, :hardware_category, :string
  end

  def self.down
    remove_column :hardware, :hardware_category
  end
end
