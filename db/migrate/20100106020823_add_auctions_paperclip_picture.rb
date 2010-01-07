class AddAuctionsPaperclipPicture < ActiveRecord::Migration
  def self.up
    add_column :auctions, :picture_file_name, :string
    add_column :auctions, :picture_content_type, :string
    add_column :auctions, :picture_file_size, :integer
    add_column :auctions, :picture_updated_at, :datetime
  end

  def self.down
    %w[picture_file_name picture_content_type picture_file_size picture_update_at].each do |column|
      remove_column :auctions, column
    end
  end
end
