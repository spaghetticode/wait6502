class CreateCoCpuTypes < ActiveRecord::Migration
  def self.up
    create_table :co_cpu_types, :id => false do|t|
      t.string :name, :null => false, :unique => true
    end
    ['I/O', 'audio', 'video', 'generic', 'math'].each do |type|
      execute "insert into co_cpu_types values('#{type}')"
    end
  end

  def self.down
    drop_table :co_cpu_types
  end
end
