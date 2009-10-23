class CreateCoCpusComputers < ActiveRecord::Migration
  def self.up
    create_table :co_cpus_computers, :id => false do |t|
      t.integer :computer_id, :co_cpu_id
    end
  end

  def self.down
    drop_table :co_cpus_computers
  end
end
