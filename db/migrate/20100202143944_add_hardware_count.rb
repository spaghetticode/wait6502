class AddHardwareCount < ActiveRecord::Migration
  def self.up
    add_column :letters, :hardware_count, :integer, :default => 0
    
    #updating letters hardware count:
    Hardware.all.each{|h| h.touch}
    Letter.reset_column_information
    Letter.all.each do |letter|
      letter.update_attribute :hardware_count, letter.hardware.size
    end
  end

  def self.down
    remove_column :letters, :hardware_count
  end
end
