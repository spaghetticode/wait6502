Given /^a country named "([^\"]*)" belongs to a manufacturer$/ do |name|
  country = Given "a country named \"#{name}\" exists"
  manufacturer = Factory(:manufacturer, :country => country)
  country.manufacturers.should include(manufacturer)
end

Given /^I attach a valid flag image$/ do
  attach_file('Flag file', File.join(RAILS_ROOT, 'public/images/rails.png'), 'image/png')
end

Then /^the "([^\"]*)" country flag file should exist$/ do |name|
  country = Country.find_by_name(name)
  country.should have_flag
  path = File.join(Country::FS_PATH, Country::URL_PATH, country.flag_filename)  
  country.send(:flag_path).should == path
  File.delete(path)
end