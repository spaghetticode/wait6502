class AddBuiltinLanguagesPermalink < ActiveRecord::Migration
  def self.up
    add_column :builtin_languages, :permalink, :string, :unique => true
  end

  def self.down
    remove_column :builtin_languages, :permalink
  end
end
