class Country < ActiveRecord::Base
  set_primary_key :name
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def initialize(fields={})
    super
    fields.each do |field, value|
      self[field] = value
    end
  end
end
