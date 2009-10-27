Given /^I have a computer named "([^\"]*)"$/ do |name|
  @computer = Factory(:computer, :name => name)
  @computer.name.should == name
end

Given /^some basic data exists$/ do
  Factory(:manufacturer, :name => 'Apple')
  Factory(:computer_type, :name => 'personal')
  Factory(:peripheral_type, :name => 'printer')
end

Given /^I have a peripheral named "([^\"]*)"$/ do |name|
  @peripheral = Factory(:peripheral, :name => name)
  @peripheral.name.should == name
end
