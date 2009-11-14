class AddEbaySitesCurrencyId < ActiveRecord::Migration
  def self.up
    add_column :ebay_sites, :currency_id, :string
  end

  def self.down
    remove_column :ebay_sites, :currency_id
  end
end
