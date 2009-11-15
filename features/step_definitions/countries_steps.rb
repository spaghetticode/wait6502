Given /^a country named "([^\"]*)" belongs to a manufacturer$/ do |name|
  country = Given "a country named \"#{name}\" exists"
  manufacturer = Factory(:manufacturer, :country => country)
  country.manufacturers.should include(manufacturer)
end

Given /^I attach a valid flag image$/ do
  attach_file('Flag image', File.join(RAILS_ROOT, 'public/images/rails.png'), 'image/png')
end

Then /^the "([^\"]*)" country flag file should exist$/ do |name|
  filename = Country.find_by_name(name).flag_image_filename
  path = File.join(Country::FS_PATH, filename)
  puts "#{path}"
  File.file?(path).should be_true
  File.delete(path)
end