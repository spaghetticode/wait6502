@focus
Feature: Website-wide search
	In order to easily find what I am looking for
	As a website user
	I want to be able to search the website
	
	Background:
		Given the following hardware exists:
			| name       | manufacturer| category  |
			| Amiga 1000 | Commodore   | computer  |
			| DuoDisk    | Apple       | peripheral|
			| Amiga Drive| Commodore   | peripheral|
		
	Scenario: Search Form is Present
		When I go to the homepage
		Then I should see the search form
		
	Scenario: Successful Search (both computers and peripherals)
		Given I am on the homepage
		When  I fill in "query" with "Amiga"
		And   I press "search"
		Then  I should see "Computers"
		And   I should see "Amiga 1000"
		And   I should see "Peripherals"
		And   I should see "Amiga Drive"
		But   I should not see "DuoDisk"
	
	Scenario: Successful Search (only peripherals)
		Given I am on the homepage
		When  I fill in "query" with "DuoDisk"
		And   I press "search"
		Then  I should see "Peripherals"
		And   I should see "Duodisk"
		But   I should not see "Computers"
		And   I should not see "Amiga"
	
	Scenario: Query is blank
		Given I am on the homepage
		When  I fill in "query" with "  "
		And   I press "search"
		Then  I should see "Please refine your search keywords."
	
	Scenario: Query is too short
		Given I am on the homepage
		When  I fill in "query" with "A"
		And   I press "search"
		Then  I should see "Please refine your serach keywords."
		