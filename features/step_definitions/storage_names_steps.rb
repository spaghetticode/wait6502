Given /^a storage name named "([^\"]*)" exists$/ do |name|
  StorageName.create!(:name => name)
  StorageName.find_by_name(name).should_not be_nil
end
