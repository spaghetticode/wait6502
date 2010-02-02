class CreateLetters < ActiveRecord::Migration
  def self.up
    create_table :letters do |t|
      t.string :name
    end
    
    # creating letters, if they don't exist
    if Letter.count.zero?
      ('a'..'z').each do |letter|
        Letter.create!(:name => letter)
      end
      (0..9).each do |number|
        Letter.create!(:name => number)
      end
    end
  end

  def self.down
    drop_table :letters
  end
end
