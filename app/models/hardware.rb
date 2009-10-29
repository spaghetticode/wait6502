class Hardware < ActiveRecord::Base
  set_table_name :hardware
  
  belongs_to :manufacturer
  validates_presence_of :name, :manufacturer
  validates_uniqueness_of :name, :scope => [:manufacturer_id, :code], :case_sensitive => false
end
