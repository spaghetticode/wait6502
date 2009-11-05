class AddHardwareJoinTables < ActiveRecord::Migration
  TABLES = {
    :co_cpus_hardware => :co_cpu_id,
    :cpus_hardware => :cpu_id,
    :hardware_io_ports => :io_port_id,
    :builtin_storages_hardware => :builtin_storage_id,
    :hardware_operative_systems => :operative_system_id,
  }
  
  def self.up
    TABLES.each do |table_name, association_field|
      create_table table_name, :id => false do |t|
        t.integer :hardware_id, association_field
      end
    end
  end
  
  def self.down
    TABLES.keys.each do |table_name|
      drop_table table_name
    end
  end
end
