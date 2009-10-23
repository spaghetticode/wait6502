class CreateComputersCpus < ActiveRecord::Migration
  def self.up
    create_table :computers_cpus, :id => false do |t|
      t.integer :computer_id, :cpu_id
    end
  end

  def self.down
    drop_table :computers_cpus
  end
end
