Given /^a computer type named "([^\"]*)" exists$/ do |name|
  lambda do
    ComputerType.create!(:name => name)
  end.should change(ComputerType, :count).by(1)
end
