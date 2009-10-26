class CreatePeripheralTypes < ActiveRecord::Migration
  def self.up
    create_table :peripheral_types, :id => false do |t|
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :peripheral_types
  end
end
