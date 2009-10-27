Given /^a peripheral type named "([^\"]*)" is associated to a peripheral$/ do |name|
  type = PeripheralType.create!(:name => name)
  peripheral = Factory(:peripheral, :peripheral_type => type)
  type.peripherals.should include(peripheral)
end
