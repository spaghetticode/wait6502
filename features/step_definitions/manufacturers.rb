Given /^a manufacturer named "([^\"]*)" exists$/ do |name|
  lambda do
    Manufacturer.create!(:name => name)
  end.should change(Manufacturer, :count).by(1)
end

Given /^I cache the manufacturers count$/ do
  @count = Manufacturer.count
end

Then /^a new manufacturer should not exist$/ do
  Manufacturer.count.should == @count
end

Then /^a new manufacturer should exist$/ do
  Manufacturer.count.should == @count + 1
end