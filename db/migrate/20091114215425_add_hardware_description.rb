class AddHardwareDescription < ActiveRecord::Migration
  def self.up
    add_column :hardware, :description, :text
  end

  def self.down
    remove_column :hardware, :description
  end
end
