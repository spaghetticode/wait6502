class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.integer :hardware_id, :null => false
      t.string :ebay_site_id, :null => false
      t.string :currency_id, :null => false
      t.string :title, :null => false
      t.string :url, :null => false
      t.string :image_url
      t.string :item_id, :null => false
      t.string :cosmetic_conditions, :null => false
      t.string :completeness, :null => false
      t.decimal :final_price, :scale => 2, :precision => 11
      t.datetime :end_time, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
