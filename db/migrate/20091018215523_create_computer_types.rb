class CreateComputerTypes < ActiveRecord::Migration
  def self.up
    create_table :computer_types, :id => false do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :computer_types
  end
end
