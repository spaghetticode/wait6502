class AddCountriesFlag < ActiveRecord::Migration
  def self.up
    add_column :countries, :flag_file_name, :string
    add_column :countries, :flag_content_type, :string
    add_column :countries, :flag_file_size, :integer
    add_column :countries, :flag_updated_at, :datetime
  end

  def self.down
    %w[flag_file_name flag_content_type flag_file_size flag_update_at].each do |column|
      remove_column :countries, column
    end
  end
end
