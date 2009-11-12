Given /^some data exists for cpu names, bits, families, manufacturers$/ do
  %w{68000 6502 Z80}.each do |name|
    CpuName.create!(:name => name)
  end
  %w{8bit 16bit 32bit}.each do |bit|
    CpuBit.create!(:name => bit)
  end
  %w{65XX X86 68K}.each do |family|
    CpuFamily.create!(:name => family)
  end
  %w{Motorola Zilog MOS}.each do |manufacturer|
    Manufacturer.create!(:name => manufacturer)
  end
end

Given /^a cpu "([^\"]*)" has been created$/ do |description|
  manufacturer, name, clock, bit, family = description.split(' ')
  manufacturer = Manufacturer.find_by_name(manufacturer)
  name = CpuName.find_by_name(name)
  bit = CpuBit.find_by_name(bit)
  family = CpuFamily.find_by_name(family) if family
  Cpu.create!(
    :cpu_name=> name,
    :cpu_family => family,
    :manufacturer => manufacturer,
    :cpu_bit => bit,
    :clock => clock)
end

Given /^existing cpu is associated to a hardware$/ do
  cpu = Cpu.first
  hardware = Factory(:hardware)
  cpu.hardware << hardware
  hardware.cpus.should include(cpu)
end

Given /^a cpu (\w+) named "(.*)" is part of a CPU$/ do |type, name|
  field = "cpu_#{type}"
  record = Factory(field, :name => name)
  cpu = Factory(:cpu, field => record)
  cpu.send(field).should == record
end
