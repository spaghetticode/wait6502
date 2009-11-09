Given /^I search ebay "(\w+)" for "([^\"]*)"$/ do |site, keyword|
  Given "I have a hardware named \"Amiga 1000\""
  Given "a currency named \"USD\" exists"
  Given "a currency named \"EUR\" exists"
  Given "I am on the auctions page"
	Given "I fill in \"Keywords\" with \"keyword\""
	Given "I select \"#{site}\" from \"Ebay site\""
end

Given /^I get at least one result/ do
  Given "I stub search requests to ebay"
  Given "I press \"search\""
end

Given /^I am already following auction with id "([^\"]*)"$/ do |item_id|
  Factory(:auction, :item_id => item_id)
end
