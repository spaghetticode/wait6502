@focus
Feature: Sort Auctions
	In order to view auctions data in the correct order
	As a logged user
	I want to sort auctions
	
	Background:
		Given I am logged in as user
		And   the following auctions exist:
		| hardware     | ebay_site | title      |
		| Commodore 64 | DE        | C64 OVP    |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Lisa         | US        | Apple LISA |
		And  I am on the auctions page

	Scenario: Sort Auctions by Title
		When I select "title" from "Order"
		And  I press "find"
		Then I should see auctions table
		| hardware     | ebay_site | title      |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Lisa         | US        | Apple LISA |	
		| Commodore 64 | DE        | C64 OVP    |
	
	Scenario: Sort Auction by Ebay Site
		When I select "ebay website" from "Order"
		And  I press "find"
		Then I should see auctions table
		| hardware     | ebay_site | title      |
		| Commodore 64 | DE        | C64 OVP    |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Lisa         | US        | Apple LISA |

	Scenario: Sort Auction by Ebay Site DESC
		When I select "ebay website" from "Order"
		And  I check "Desc"
		And  I press "find"
		Then I should see auctions table
		| hardware     | ebay_site | title      |
		| Lisa         | US        | Apple LISA |
		|	Amiga 1000   | IT        | Amiga 1000 |
		| Commodore 64 | DE        | C64 OVP    |
 
	Scenario: Sort only Active Auctions
		Given the auction titled "Amiga 1000" is closed
		And   I am on the auctions page
		When  I follow "active"
		And   I select "title" from "Order"
		And   I press "find"
		Then  I should see auctions table
		| hardware     | ebay_site | title      |
		| Lisa         | US        | Apple LISA |
		| Commodore 64 | DE        | C64 OVP    |
	
	Scenario: Sort only Closed Auctions
	Given the auction titled "Amiga 1000" is closed
	And   the auction titled "Apple LISA" is closed
	And   I am on the auctions page
	When  I follow "closed"
	But   I should not see "C64 OVP"
	When  I select "ebay website" from "Order"
	And   I check "Desc"
	And   I press "find"
	Then  I should see auctions table
	| hardware     | ebay_site | title      |
	| Lisa         | US        | Apple LISA |
	|	Amiga 1000   | IT        | Amiga 1000 |
