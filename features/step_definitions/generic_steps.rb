Given /^some currencies and countries exist$/ do
  %w{EUR ITL USD}.each do |currency|
    Currency.create!(:name => currency)
  end
  %w{Italy Spain USA Canada France}.each do |country|
    Country.create!(:name => country)
  end
end

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

Given /^a operative system named "(.+)" has a hardware associated$/ do |name|
  hardware = Factory(:hardware)
  operative_system = Factory(:operative_system, :name => name)
  hardware.operative_systems << operative_system
  operative_system.hardware.should include(hardware)
end

Given /^a ([\w\s]+) named "([^\"]*)" is associated to a hardware$/ do |model, name|
  attribute = model.gsub(' ', '_')
  Factory(:hardware, attribute => Factory(attribute, :name => name))
end

Then /^I should see (hardware|auctions) table$/ do |model, table|
  expected_rows = table.hashes.map(&:values)
  actual_rows = table_at('.list').to_a
  expected_rows.each_with_index do |row, i|
    actual_row = actual_rows[i+1].map{|cell| cell.gsub(/<.+?>/, '') }
    row.each do |cell|
      actual_row.should include(cell)
    end
  end
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
  when /hardware type/
    HardwareType
  when /ebay site/
    EbaySite
  end
end