class AddCountriesFlagFilename < ActiveRecord::Migration
  def self.up
    add_column :countries, :flag_filename, :string
  end

  def self.down
    remove_column :countries, :flag_filename
  end
end
