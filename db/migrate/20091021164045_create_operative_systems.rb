class CreateOperativeSystems < ActiveRecord::Migration
  def self.up
    create_table :operative_systems, :id => false do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :operative_systems
  end
end
