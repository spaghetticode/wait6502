class AddCoCpusCpuFamilyId < ActiveRecord::Migration
  def self.up
    add_column :co_cpus, :cpu_family_id, :string
  end

  def self.down
    remove_column :co_cpus, :cpu_family_id
  end
end
