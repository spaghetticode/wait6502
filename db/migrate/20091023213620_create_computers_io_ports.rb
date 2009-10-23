class CreateComputersIoPorts < ActiveRecord::Migration
  def self.up
    create_table :computers_io_ports, :id => false do |t|
      t.integer :computer_id, :io_port_id
    end
  end

  def self.down
    drop_table :computers_io_ports
  end
end
