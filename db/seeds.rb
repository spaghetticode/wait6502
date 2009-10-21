password = 'secret'
User.create!(:email => 'admin@test.com', :password => password, :password_confirmation => password)

['Home', 'Personal', 'Portable', 'Pocket'].each do |name|
  ComputerType.create!(:name => name)
end

%w{Italy USA France Germany Japan}.each do |country|
  Country.create!(:name => country)
end

[%w{EUR EURO}, %w{USD $}, %w{JPY ¥}].each do |currency|
  Currency.create!(:code => currency[0], :symbol => currency[1])
end

%w{Motorola Atari Apple Commodore Zilog Sinclair}.each do |brand|
  Manufacturer.create!(:name => brand)
end

%w{ X86 65XX Z80}.each do |family|
  CpuFamily.create!(:name => family)
end
  
%w{ Z80 6502 68000}.each do |cpu|
  CpuName.create!(:name => cpu)
end