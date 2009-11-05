Given /^I have a hardware named "([^\"]*)"$/ do |name|
  @hardware = Factory(:hardware, :name => name)
  @hardware.name.should == name
end

Given /^some basic data exists$/ do
  Factory(:manufacturer, :name => 'Apple')
  Factory(:hardware_type, :name => 'personal computer')
end