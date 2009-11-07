class CreateOriginalPrices < ActiveRecord::Migration
  def self.up
    create_table :original_prices do |t|
      t.string :currency_id
      t.string :country_id
      t.date :date
      t.string :amount
      t.integer :purchaseable_id
      t.string :purchaseable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :original_prices
  end
end
