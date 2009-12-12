class AddUsersLastRequestAt < ActiveRecord::Migration
  def self.up
    add_column :users, :last_request_at, :datetime
  end

  def self.down
    remove_column :users, :last_request_at, :datetime
  end
end
