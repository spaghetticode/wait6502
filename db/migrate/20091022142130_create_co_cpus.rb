class CreateCoCpus < ActiveRecord::Migration
  def self.up
    create_table :co_cpus do |t|
      t.string :co_cpu_name_id
      t.string :co_cpu_type_id
      t.integer :manufacturer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :co_cpus
  end
end
