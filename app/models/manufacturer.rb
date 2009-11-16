class Manufacturer < ActiveRecord::Base
  belongs_to :country
  has_many :hardware
  has_many :cpus
  has_many :co_cpus
  
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  named_scope :ordered, :order => 'name'
  
  SEARCH_FIELDS = { :name => 'manufacturers.name', :country => 'countries.name'}
  
  def self.concat_query
    string  = SEARCH_FIELDS.values.inject([]) do |fields, field|
      fields << "IFNULL(#{field}, '')"
    end
    "concat(#{string.join(', ')}) like ?"
  end
end
