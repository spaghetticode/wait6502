class CreateComputersOperativeSystems < ActiveRecord::Migration
  def self.up
    create_table :computers_operative_systems, :id => false do |t|
      t.integer :computer_id, :operative_system_id
    end
  end

  def self.down
    drop_table :computers_operative_systems
  end
end
