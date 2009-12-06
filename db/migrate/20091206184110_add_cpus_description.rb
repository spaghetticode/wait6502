class AddCpusDescription < ActiveRecord::Migration
  def self.up
    add_column :cpus, :description, :text
  end

  def self.down
    remove_column :cpus, :description
  end
end
