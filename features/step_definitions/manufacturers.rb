Given /^a manufacturer named "([^\"]*)" exists$/ do |name|
  lambda do
    Manufacturer.create!(:name => name)
  end.should change(Manufacturer, :count).by(1)
end