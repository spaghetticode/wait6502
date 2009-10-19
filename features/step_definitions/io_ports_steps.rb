Given /^a io port with name "([^\"]*)" and connector "([^\"]*)" exists$/ do |name, connector|
  IoPort.create!(
    :name => name,
    :connector => connector
  )
end
