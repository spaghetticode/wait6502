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

Given /^a cpu "([^\"]*)" exists$/ do |description|
  manufacturer, name, clock, bit, family = description.split(' ')
  manufacturer = Manufacturer.find_by_name(manufacturer)
  name = CpuName.find_by_name(name)
  bit = CpuBit.find_by_name(bit)
  family = CpuFamily.find_by_name(family)
  Cpu.create!(
    :cpu_name=> name,
    :cpu_family => family,
    :manufacturer => manufacturer,
    :cpu_bit => bit,
    :clock => clock)
end