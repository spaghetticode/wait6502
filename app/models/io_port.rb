class IoPort < ActiveRecord::Base
  has_and_belongs_to_many :hardware, :join_table => :hardware_io_ports
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :connector, :case_sensitive => false
  
  named_scope :ordered, :order => 'name'
  
  SEARCH_FIELDS = {:name => 'name', :connector => 'connector'}
  
  acts_as_permalink :full_name
  
  def self.filter(params)
    conditions = [self.ilike_string, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'name'} #{params[:desc]}"
    )
  end
  
  def self.ilike_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "COALESCE(#{field}, '')"
    end.join(' || ')
    "#{string} ILIKE ?"
  end
  
  def full_name
    connector_name = "(#{connector} connector)" unless connector.blank?
    [name, connector_name].join(' ')
  end
end
