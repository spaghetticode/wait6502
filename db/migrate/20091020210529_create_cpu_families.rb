class CreateCpuFamilies < ActiveRecord::Migration
  def self.up
    create_table :cpu_families, :id => false do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :cpu_families
  end
end
