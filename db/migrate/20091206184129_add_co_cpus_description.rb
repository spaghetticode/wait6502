class AddCoCpusDescription < ActiveRecord::Migration
  def self.up
    add_column :co_cpus, :description , :text
  end

  def self.down
    remove_column :co_cpus, :description
  end
end
