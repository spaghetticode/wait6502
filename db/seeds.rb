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