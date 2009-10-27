class CreateIoPortsPeripherals < ActiveRecord::Migration
  def self.up
    create_table :io_ports_peripherals, :id => false do |t|
      t.integer :peripheral_id, :io_port_id
    end
  end

  def self.down
    drop_table :io_ports_peripherals
  end
end
