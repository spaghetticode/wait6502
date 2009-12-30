class Hardware < ActiveRecord::Base
  set_table_name :hardware

  belongs_to :manufacturer  
  belongs_to :hardware_type
  belongs_to :builtin_language
  
  has_many :auctions
  has_many :images, :as => :imageable
  has_many :original_prices, :as => :purchaseable
  
  has_and_belongs_to_many :cpus, :join_table => :cpus_hardware
  has_and_belongs_to_many :co_cpus, :join_table => :co_cpus_hardware
  has_and_belongs_to_many :io_ports, :join_table => :hardware_io_ports
  has_and_belongs_to_many :builtin_storages, :join_table => :builtin_storages_hardware
  has_and_belongs_to_many :operative_systems, :join_table => :hardware_operative_systems
  
  validates_presence_of :name, :manufacturer, :hardware_type, :hardware_category
  validates_uniqueness_of :name, :scope => [:manufacturer_id, :code], :case_sensitive => false
  
  acts_as_permalink :name
  
  CATEGORIES = %w{computer peripheral}
  SEARCH_FIELDS = {
    :name => 'hardware.name',
    :type => 'hardware_types.name',
    :manufacturer => 'manufacturers.name',
    'co CPU name' => 'co_cpus.co_cpu_name_id',
    'builtin_language' => 'hardware.builtin_language_id',
    'CPU name' => 'cpus.cpu_name_id',
    'I/O port connector' => 'io_ports.connector',
    'I/O port name' => 'io_ports.name',
    'storage name' => 'builtin_storages.storage_name_id',
    'storage format' => 'builtin_storages.storage_format_id',
    'storage size' => 'builtin_storages.storage_size_id',
    'operative systems name' => 'operative_systems.name',
  }
  
  CATEGORIES.each do |category|
    named_scope category, :conditions => {:hardware_category => category}
  end
  
  named_scope :ordered, :order => 'hardware.name'
  named_scope :by_manufacturer, :order => 'manufacturers.name', :include => :manufacturer
  named_scope :filter_initial, lambda{|letter| {:conditions => ['hardware.name like ?', "#{letter}%"]}}
  
  def self.filter(params)
    all(
      :order => "#{params[:order] || 'hardware.name'} #{params[:desc]}",
      :conditions => self.conditions(params),
      :include => [:hardware_type, :cpus, :co_cpus, :builtin_storages, :operative_systems, :io_ports, :manufacturer]
    )
  end
  
  def self.conditions(params)
    strings = []
    values = []
    unless params[:category].blank?
      strings << 'hardware_category=?'
      values << "#{params[:category]}"
    end
    unless params[:keywords].blank?
      strings << "concat(#{search_field_string}) like ?"
      values << "%#{params[:keywords]}%"
    end
    conditions = [ strings.join(' AND '), values ].flatten
  end
  
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
  
  def full_name
    name.include?(manufacturer.name) ? name : [manufacturer.name, name].join(' ')
  end
  
  private
  
  def self.search_field_string
    SEARCH_FIELDS.values.inject([]) do |collection, field|
      collection << "IFNULL(#{field}, '')"
    end.join(', ')
  end
end