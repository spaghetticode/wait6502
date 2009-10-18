Given /^a country named "([^\"]*)" exists$/ do |name|
  lambda do
    Country.create!(:name => name)
  end.should change(Country, :count).by(1)
end

