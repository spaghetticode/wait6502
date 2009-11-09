@focus
Feature: Watch ebay auctions
	In order to follow ebay auctions
	As a logegd user
	I want to watch auctions included in resultsets
	
	Background:
		Given I am logged in as user
		And the following ebay sites exist:
		| name |
		| IT   |
		| US   |
		| DE   |
		
	Scenario: Follow Auction from ebay resultset
		Given I stub image downloads from ebay
		And   I search ebay "IT" for "Amiga 1000"
		And   I get at least one result
		When  I select "good" from "auction_cosmetic_conditions"
		And   I select "complete with extras" from "auction_completeness"
		And   I select "Amiga 1000" from "auction_hardware_id"
		And   I press "watch"
		Then  I should see "Auction was successfully created"
		And   I should be on the auctions page
		And   I should see "Amiga 1000"
		And   I should see "good"
		And   I should see "complete with extras"
		
	Scenario: Won't allow to follow an auction that is already watched
		Given I am already following auction with id "170402561257"
		When  I search ebay "IT" for "Amiga 1000"
		And   I get at least one result
		Then  I should see "You are already watching this auction"
		