class AddHardwareTrivia < ActiveRecord::Migration
  def self.up
    add_column :hardware, :trivia, :text
  end

  def self.down
    remove_column :hardware, :trivia
  end
end
