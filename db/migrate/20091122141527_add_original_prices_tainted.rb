class AddOriginalPricesTainted < ActiveRecord::Migration
  def self.up
    add_column :original_prices, :tainted, :boolean
  end

  def self.down
    remove_column :original_prices, :tainted
  end
end
