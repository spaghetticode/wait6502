class CreateCoCpuNames < ActiveRecord::Migration
  def self.up
    create_table :co_cpu_names, :id => false do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :co_cpu_names
  end
end
