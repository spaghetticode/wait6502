class CreateBuiltinLanguages < ActiveRecord::Migration
  def self.up
    create_table :builtin_languages, :id => false do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :builtin_languages
  end
end
