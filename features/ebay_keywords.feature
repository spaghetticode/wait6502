Feature: Manage Ebay Keywords
	In order to add ebay search keywords to computers and peripherals
	As a logged user
	I want to manage ebay keywords
	
	Background:
		Given I am logged in as user
		And   I have a computer named "Amiga 1000"
		And   I have a peripheral named "DuoDisk"
		
	Scenario: Access is restricted
		Given I am logged out
		When  I go to the "Amiga 1000" computer keywords page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Keywords
		Given I am on the "Amiga 1000" computer editor page
		And   I follow "Ebay Keywords"
		Then  I should be on the "Amiga 1000" computer keywords page
		And   I should see "Ebay Keywords for"
		
	Scenario: Creating New Keyword
		Given I am on the "Amiga 1000" computer keywords page
		And   I follow "new ebay keyword"
		When  I fill in "Name" with "amiga1000"
		And   I press "create"
		Then  I should see "Ebay Keyword was successfully created."
		And   I should be on the "Amiga 1000" computer keywords page
		And   I should see "amiga1000"
		
	Scenario: Failed New Keyword Creation
	Given I created a keyword "Amiga 1000" for "Amiga 1000" computer
		And   I am on the "Amiga 1000" computer keywords page
		And   I follow "new ebay keyword"
		And   I fill in "Name" with "amiga 1000"
		And   I press "Create"
		Then  I should see "Name has already been taken"

	Scenario: Destroying Keyword
		Given I created a keyword "amiga1000" for "Amiga 1000" computer
		And   I am on the "Amiga 1000" computer keywords page
		And   I should see "amiga1000"
		When  I follow "destroy"
		Then  I should see "Ebay Keyword was successfully destroyed"
		And   I should be on the "Amiga 1000" computer keywords page