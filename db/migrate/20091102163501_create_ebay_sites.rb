class CreateEbaySites < ActiveRecord::Migration
  def self.up
    create_table :ebay_sites, :id => false do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ebay_sites
  end
end
