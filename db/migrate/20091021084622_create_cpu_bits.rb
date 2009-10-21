class CreateCpuBits < ActiveRecord::Migration
  def self.up
    create_table :cpu_bits, :id => false do |t|
      t.integer :name, :null => false, :unique => true
    end
    ['4 bit', '8 bit', '16 bit', '32 bit', '4/8 bit', '8/16 bit', '16/32 bit'].each do |bit|
      execute "insert into cpu_bits values('#{bit}')"
    end
  end

  def self.down
  end
end
