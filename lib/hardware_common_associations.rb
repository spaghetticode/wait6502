module HardwareCommonAssociations
  def self.included(base)
    base.send(:has_and_belongs_to_many, :io_ports)
    base.send(:has_and_belongs_to_many, :cpus)
    base.send(:has_and_belongs_to_many, :builtin_storages)
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