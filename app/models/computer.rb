class Computer < Hardware
  include HardwareCommonAssociations
    
  belongs_to :computer_type
  belongs_to :builtin_language
  has_and_belongs_to_many :operative_systems
  has_and_belongs_to_many :co_cpus
  has_many :original_prices, :as => :purchaseable
  
  validates_presence_of :computer_type
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, hardware.name'
  
  def co_cpu_names
    co_cpus.map{|cc| "#{cc.manufacturer.name} #{cc.co_cpu_name_id}"}.join(', ')
  end
  
  def os_names
    operative_systems.map(&:name).join(', ')
  end
end
