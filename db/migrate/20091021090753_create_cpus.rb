class CreateCpus < ActiveRecord::Migration
  def self.up
    create_table :cpus do |t|
      t.string :cpu_bit_id, :null => false
      t.string :cpu_family_id
      t.integer :manufacturer_id, :null => false
      t.string :cpu_name_id, :null => false
      t.string :clock

      t.timestamps
    end
  end

  def self.down
    drop_table :cpus
  end
end
