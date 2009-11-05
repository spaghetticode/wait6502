Given /^some co cpu names and types and manufacturers exist$/ do
  %w{8087 Paula}.each do |name|
    CoCpuName.create!(:name => name)
  end
  %w{Audio Math}.each do |type|
    CoCpuType.create!(:name => type)
  end
  %w{Intel CSG}.each do |name|
    Manufacturer.create!(:name => name)
  end
end

Given /^a co cpu "([^\"]*)" exists$/ do |values|
  m_name, c_name, c_type = values.split(' ')
  manufacturer = Manufacturer.find_by_name(m_name)
  name = CoCpuName.find_by_name(c_name)
  type = CoCpuType.find_by_name(c_type)
  lambda do
    @co_cpu = CoCpu.create!(:co_cpu_name => name, :co_cpu_type => type, :manufacturer => manufacturer)
  end.should change(CoCpu, :count).by(1)
  @co_cpu
end

Given /^a co cpu "([^\"]*)" is associated to a hardware$/ do |fields|
  co_cpu = Given "a co cpu \"#{fields}\" exists"
  hardware = Factory(:hardware)
  co_cpu.hardware << hardware
  hardware.co_cpus.should include(co_cpu)
end
