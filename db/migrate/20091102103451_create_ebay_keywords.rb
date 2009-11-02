class CreateEbayKeywords < ActiveRecord::Migration
  def self.up
    create_table :ebay_keywords do |t|
      t.string :name
      t.integer :searchable_id
      t.string :searchable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :ebay_keywords
  end
end
