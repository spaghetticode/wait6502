class CreateEbaySites < ActiveRecord::Migration
  def self.up
    create_table :ebay_sites, :id => false do |t|
      t.string :name, :null => false
      t.string :site_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ebay_sites
  end
end
