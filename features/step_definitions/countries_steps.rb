Given /^a country named "([^\"]*)" belongs to a manufacturer$/ do |name|
  country = Given "a country named \"#{name}\" exists"
  manufacturer = Factory(:manufacturer, :country => country)
  country.manufacturers.should include(manufacturer)
end
