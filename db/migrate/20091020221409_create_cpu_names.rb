class CreateCpuNames < ActiveRecord::Migration
  def self.up
    create_table :cpu_names, :id => false do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :cpu_names
  end
end
