Feature: Manage Auctions
	In order to have relevant auctions data
	As a logged user
	I want to manage auctions data
	
	Background:
		Given I am logged in as user
		And the following ebay sites exist:
		| name |
		| IT   |
		| US   |
		| DE   |
		And   the following auction exists:
		| hardware | ebay_site | title         |
		| Pet 2001 | US        | Commodore PET |
		
	Scenario: Access is restricted
		Given I am logged out
		When  I go to the auctions page
		Then  I should see "You must be logged in to access this page"
		And   I should be on the user login page
	
	Scenario: Listing Auctions
		Given the following auctions exist:
		| hardware     | ebay_site | title      |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Commodore 64 | DE        | C64 OVP    |
		When  I go to the auctions page
		Then  I should see "Amiga 1000"
		And   I should see "C64 OVP"
		And   I should see "Commodore 64"
		And   I should see "IT"
		And   I should see "DE"
		
	Scenario: Edit Auction
		Given I am on the auctions page
		When  I follow "Edit"
		And   I select "mint" from "Cosmetic conditions"
		And   I select "boxed with extras" from "Completeness"
		And   I press "Update"
		Then  I should see "Auction was successfully updated."
		And   I should be on the auctions page
		And   I should see "mint"
		And   I should see "boxed with extras"
		
	Scenario: Destroy Auction
		Given I am on the auctions page
		And   I should see "Pet 2001"
		When  I press "Destroy"
		Then  I should see "Auction was successfully destroyed."
		And   I should be on the auctions page
		And   I should not see "Pet 2001"
		
	Scenario: Updating Final Price Value through Ebay (auction received bids)
		Given the auction titled "Commodore PET" has ended with 1 bid
		And   I am on the auctions page
		When  I press "set final price"
		Then  I should see "Final Price for this auction was "
		
	Scenario: Updating Final Price Value through Ebay (auction received no bid)
		Given the auction titled "Commodore PET" has ended with 0 bids
		And   I am on the auctions page
		When  I press "set final price"
		Then  I should see "Auction went without bids. Please destroy it"
	
	Scenario: Failed Search for Auctions (no keywords)
		Given I am on the auctions page
		When  I press "search"
		Then  I should see "You must provide a search keyword"
		And   I should be on the auctions page
		
	Scenario: Successful Search for Auctions
		Given I stub search requests to ebay
		And   I am on the auctions page
		When  I fill in "Keywords" with "Amiga 1000"
		And   I select "IT" from "Ebay site"
		And   I press "search"
		Then  I should see "Current Auctions for Amiga 1000"
		And   I should see "COMMODORE AMIGA 1000 + MEMORY + GAMES ORIGINAL BOX"
		And   I should see "EUR 499.00"
	
	Scenario: List only Active Auctions
		Given the following auctions exist:
		| hardware     | ebay_site | title      |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Commodore 64 | DE        | C64 OVP    |
		And  the auction titled "Amiga 1000" is closed
		And  I am on the auctions page
		When I follow "active"
		Then I should not see "Amiga 1000"
		But  I should see "C64 OVP"

	Scenario: List only Closed Auctions
		Given the following auctions exist:
		| hardware     | ebay_site | title      |
		| Amiga 1000   | IT        | Amiga 1000 |
		| Commodore 64 | DE        | C64 OVP    |
		And  the auction titled "Amiga 1000" is closed
		And  I am on the auctions page
		When I follow "closed"
		Then I should see "Amiga 1000"
		But  I should not see "C64 OVP"
		