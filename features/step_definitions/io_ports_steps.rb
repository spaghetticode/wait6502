Given /^a io port with name "([^\"]*)" and connector "([^\"]*)" exists$/ do |name, connector|
  IoPort.create!(
    :name => name,
    :connector => connector
  )
end

Given /^a io port with name "([^\"]*)" has a computer associated$/ do |name|
  io_port = Given "a io port with name \"#{name}\" and connector \"\" exists"
  computer = Factory(:computer)
  io_port.computers << computer
  computer.io_ports.should include(io_port)
end
