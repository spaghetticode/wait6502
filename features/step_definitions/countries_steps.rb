Given /^a country named "([^\"]*)" exists$/ do |name|
  lambda do
    Country.create!(:name => name)
  end.should change(Country, :count).by(1)
end

Then /^I cache the countries count$/ do
  @count = Country.count
end

Then /^a new country has been created$/ do
  Country.count.should == @count + 1
end

Then /^a new country has not been created$/ do
  Country.count.should == @count
end

