Given /^I search ebay "(\w+)" for "([^\"]*)"$/ do |site, keyword|
  Given "I have a hardware named \"Amiga 1000\""
  And "a currency named \"USD\" exists"
  And "a currency named \"EUR\" exists"
  And "I am on the auctions page"
	And "I fill in \"Keywords\" with \"keyword\""
	And "I select \"#{site}\" from \"Ebay site\""
end

Given /^I get at least one result/ do
  Given "I stub search requests to ebay"
  And "I press \"search\""
end

Given /^I am already following auction with id "([^\"]*)"$/ do |item_id|
  Factory(:auction, :item_id => item_id)
end
