class CreateCpusPeripherals < ActiveRecord::Migration
  def self.up
    create_table :cpus_peripherals, :id => false do |t|
      t.integer :peripheral_id, :cpu_id
    end
  end

  def self.down
    drop_table :cpus_peripherals
  end
end
