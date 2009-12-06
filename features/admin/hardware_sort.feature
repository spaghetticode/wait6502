Feature: Sort Hardware table
In order to view hardware data in the correct order
As a logged user
I want to sort hardware table

	Background:
		Given I am logged in as user
		And   the following hardware exists:
			| name      | manufacturer| category  |
			| Amiga 1000| Commodore   | computer  |
			| Apple II  | Apple       | computer  |
			| DuoDisk   | Apple       | peripheral|
	 	And I am on the hardware page
			
	
	Scenario: Sort Hardware by Manufacturer
		When I select "manufacturer" from "Order"
		And  I press "find"
		Then I should see hardware table
		| name      | manufacturer| category  |
		| Apple II  | Apple       | computer  |
		| DuoDisk   | Apple       | peripheral|
		| Amiga 1000| Commodore   | computer  |
	
	Scenario: Sort Hardware by Name
		When I select "name" from "Order"
		And  I press "find"
		Then I should see hardware table
		| name      | manufacturer| category  |
		| Amiga 1000| Commodore   | computer  |
		| Apple II  | Apple       | computer  |
		| DuoDisk   | Apple       | peripheral|
		
		Scenario: Sort Hardware by Name DESC
			When I select "name" from "Order"
			And  I check "Desc"
			And  I press "find"
			Then I should see hardware table
			| name      | manufacturer| category  |
			| DuoDisk   | Apple       | peripheral|
			| Apple II  | Apple       | computer  |
			| Amiga 1000| Commodore   | computer  |