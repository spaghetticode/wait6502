Given /^currency with code "([^\"]*)" and symbol "([^\"]*)" exists$/ do |code, symbol|
  lambda do
    Currency.create!(:code => code, :symbol => symbol)
  end.should change(Currency, :count).by(1)
end
