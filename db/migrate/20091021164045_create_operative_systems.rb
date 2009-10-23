class CreateOperativeSystems < ActiveRecord::Migration
  def self.up
    create_table :operative_systems do |t|
      t.string :name, :null => false, :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :operative_systems
  end
end
