class AddManufacturersPaperclip < ActiveRecord::Migration
  def self.up
    %w[logo_file_name logo_content_type].each do |column|
      add_column :manufacturers, column, :string
    end
    add_column :manufacturers, :logo_file_size, :integer
    add_column :manufacturers, :logo_update_at, :datetime
  end

  def self.down
    %w[logo_file_name logo_content_type logo_file_size logo_update_at].each do |column|
      remove_column :manufacturers, column
    end
  end
end
