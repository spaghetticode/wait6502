class CreateCoCpuTypes < ActiveRecord::Migration
  def self.up
    create_table :co_cpu_types, :id => false do|t|
      t.string :name, :null => false, :unique => true
    end
  end

  def self.down
    drop_table :co_cpu_types
  end
end
