class AddEbaySitesImage < ActiveRecord::Migration
  def self.up
    add_column :ebay_sites, :image, :string
  end

  def self.down
    remove_column :ebay_sites, :image
  end
end
