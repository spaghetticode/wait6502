class AddCpusParentCpuId < ActiveRecord::Migration
  def self.up
    add_column :cpus, :parent_cpu_id, :integer
  end

  def self.down
    remove_column :cpus, :parent_cpu_id
  end
end
