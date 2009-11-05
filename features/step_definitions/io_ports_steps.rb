Given /^a io port with name "([^\"]*)" and connector "([^\"]*)" exists$/ do |name, connector|
  IoPort.create!(
    :name => name,
    :connector => connector
  )
end

Given /^a io port with name "([^\"]*)" has a hardware associated$/ do |name|
  io_port = Given "a io port with name \"#{name}\" and connector \"\" exists"
  hardware = Factory(:hardware)
  io_port.hardware << hardware
  hardware.io_ports.should include(io_port)
end
