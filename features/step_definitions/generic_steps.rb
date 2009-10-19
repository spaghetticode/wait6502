Then /^I cache the ([\w\s]+) count$/ do |model|
  klass = class_for(model)
  @count = klass.count
end

Then /^a new ([\w\s]+) has (.*)been created$/ do |model, switch|
  klass = class_for(model)
  klass.count.should == @count + (switch =~ /not/ ? 0 : 1)
end

def class_for(model)
  case model
  when /countr/
    Country
  when /user/
    User
  when /currenc/
    Currency
  when /manufacturer/
    Manufacturer
  when /computer type/
    ComputerType
  when /io port/
    IoPort
  when /storage name/
    StorageName
  end
end