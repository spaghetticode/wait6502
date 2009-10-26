Given /^I have a computer named "([^\"]*)"$/ do |name|
  @computer = Factory(:computer, :name => name)
  @computer.name.should == name
end

Given /^some basic data exists$/ do
  Factory(:manufacturer, :name => 'Apple')
  Factory(:computer_type, :name => 'personal')
end
