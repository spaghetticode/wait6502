Given /^I have a hardware named "([^\"]*)"$/ do |name|
  @hardware = Factory(:hardware, :name => name)
  @hardware.name.should == name
end

Given /^some basic data exists$/ do
  Factory(:manufacturer, :name => 'Apple')
  Factory(:hardware_type, :name => 'personal computer')
end

Given /^the following (computer|peripheral|hardware)s? exists?:$/ do |model, table|
  table.hashes.each do |hardware|
    manufacturer = Manufacturer.find_by_name(hardware[:manufacturer]) || Factory(:manufacturer, :name => hardware[:manufacturer])
    Factory(:hardware,
      :name => hardware[:name],
      :manufacturer => manufacturer,
      :hardware_category => hardware[:category] || 'computer'
    )
  end
end
