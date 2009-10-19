class CreateIoPorts < ActiveRecord::Migration
  def self.up
    create_table :io_ports do |t|
      t.string :name, :null => false
      t.string :connector

      t.timestamps
    end
  end

  def self.down
    drop_table :io_ports
  end
end
