Given /^a ([\w\s]+) named "([^\"]*)" exists$/ do |model, name|
  klass = class_for(model)
  lambda do
    @model = klass.create!(:name => name)
  end.should change(klass, :count).by(1)
  @model
end

Given /^I cache the ([\w\s]+) count$/ do |model|
  klass = class_for(model)
  @count = klass.count
end

Given /^a new ([\w\s]+) has (.*)been created$/ do |model, switch|
  klass = class_for(model)
  klass.count.should == @count + (switch =~ /not/ ? 0 : 1)
end

Given /^a ([\w\s]+) named "([^\"]*)" is associated to a computer$/ do |model, name|
  record = Given "a #{model} named \"#{name}\" exists"
  computer = Factory(:computer)
  case record
  when ComputerType
    computer.update_attribute(:computer_type, record)
  when Manufacturer
    computer.update_attribute(:manufacturer, record)
  else
    record.computers << computer
  end
  record.computers.should include(computer)
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
  when /storage format/
    StorageFormat
  when /storage size/
    StorageSize
  when /cpu famil/
    CpuFamily
  when /co cpu name/
    CoCpuName
  when /cpu name/
    CpuName
  when /co cpu/
    CoCpu
  when /cpu/
    Cpu
  when /operative system/
    OperativeSystem
  when /builtin language/
    BuiltinLanguage
  end
end