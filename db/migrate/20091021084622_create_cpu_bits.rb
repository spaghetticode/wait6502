class CreateCpuBits < ActiveRecord::Migration
  def self.up
    create_table :cpu_bits, :id => false do |t|
      t.string :name, :null => false, :unique => true
    end
  end

  def self.down
  end
end
