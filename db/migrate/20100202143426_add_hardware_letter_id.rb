class AddHardwareLetterId < ActiveRecord::Migration
  def self.up
    add_column :hardware, :letter_id, :integer
  end

  def self.down
    remove_column :hardware, :letter_id
  end
end
