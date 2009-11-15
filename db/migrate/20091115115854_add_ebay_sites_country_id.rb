class AddEbaySitesCountryId < ActiveRecord::Migration
  def self.up
    add_column :ebay_sites, :country_id, :string
  end

  def self.down
    remove_column :ebay_sites, :country_id
  end
end
