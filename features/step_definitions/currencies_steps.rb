Given /^currency with code "([^\"]*)" and symbol "([^\"]*)" exists$/ do |code, symbol|
  lambda do
    Currency.create!(:code => code, :symbol => symbol)
  end.should change(Currency, :count).by(1)
end

Given /^I cache the currencies count$/ do
  @count = Currency.count
end

Then /^a new currency has not been created$/ do
  Currency.count.should == @count
end

Given /^I am logged out$/ do
  visit logout_path
end
