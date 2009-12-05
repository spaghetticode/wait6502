class IoPort < ActiveRecord::Base
  has_and_belongs_to_many :hardware, :join_table => :hardware_io_ports
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :connector, :case_sensitive => false
  
  named_scope :ordered, :order => 'name'
  
  SEARCH_FIELDS = {:name => 'name', :connector => 'connector'}
  
  def self.filter(params)
    conditions = [self.concat_string, "%#{params[:keywords]}%"] unless params[:keywords].blank?
    all(
      :conditions => conditions,
      :order => "#{params[:order] || 'name'} #{params[:desc]}"
    )
  end
  
  def self.concat_string
    string = SEARCH_FIELDS.values.inject([]) do |group, field|
      group << "IFNULL(#{field}, '')"
    end.join(', ')
    "concat(#{string}) like ?"
  end
  
  def full_name
    "#{name} (#{connector} connector)"
  end
end
