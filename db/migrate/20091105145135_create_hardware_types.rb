class CreateHardwareTypes < ActiveRecord::Migration
  def self.up
    create_table :hardware_types, :id => false do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :hardware_types
  end
end
