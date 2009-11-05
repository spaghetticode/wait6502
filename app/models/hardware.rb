class Hardware < ActiveRecord::Base
  set_table_name :hardware

  belongs_to :manufacturer  
  belongs_to :hardware_type
  belongs_to :builtin_language
  
  has_many :images, :as => :imageable
  has_many :ebay_keywords, :as => :searchable
  has_many :original_prices, :as => :purchaseable

  has_and_belongs_to_many :cpus, :join_table => :cpus_hardware
  has_and_belongs_to_many :co_cpus, :join_table => :co_cpus_hardware
  has_and_belongs_to_many :io_ports, :join_table => :hardware_io_ports
  has_and_belongs_to_many :builtin_storages, :join_table => :builtin_storages_hardware
  has_and_belongs_to_many :operative_systems, :join_table => :hardware_operative_systems
  
  validates_presence_of :name, :manufacturer, :hardware_type, :hardware_category
  validates_uniqueness_of :name, :scope => [:manufacturer_id, :code], :case_sensitive => false
  
  named_scope :ordered, :include => :manufacturer, :order => 'manufacturers.name, hardware.name'
  
  CATEGORIES = %w{computer peripheral}

  def co_cpu_names
    co_cpus.map{|cc| "#{cc.manufacturer.name} #{cc.co_cpu_name_id}"}.join(', ')
  end
  
  def os_names
    operative_systems.map(&:name).join(', ')
  end
  
  def cpu_names
    cpus.map{|cpu| "#{cpu.manufacturer.name} #{cpu.cpu_name_id}"}.join(', ')
  end

  def io_port_names
    io_ports.map(&:name).join(', ')
  end
  
  def storage_names
    builtin_storages.map(&:full_name).join(', ')
  end
end
