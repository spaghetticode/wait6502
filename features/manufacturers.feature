Feature: Manage Manufacturers
	In order to add computers and CPUs manufacturer info
	As a logged in user
	I want to manage manufacturers
	
	Background:
		Given I am logged in as user
	
	Scenario: Access is limited to logged in users
		Given I am logged out
		When  I go to the manufacturers page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Manufacturers
		Given a manufacturer named "Apple" exists
		And   I am on the manufacturers page
		Then  I should see "Listing Manufacturers"
		And   I should see "Apple"
		
	Scenario: Creating New Manufacturer
		Given I am on the manufacturers page
		And   I cache the manufacturers count
		And   I follow "new manufacturer"
		When  I fill in "name" with "Apple"
		And   I fill in "country" with "USA"
		And   I press "create"
		Then  I should see "Manufacturer was successfully created"
		And   I should be on the manufacturers page
		And   I should see "Apple"
		And   a new manufacturer should exist
		
	Scenario: Failed New Manufacturer Creation
		Given a manufacturer named "Commodore" exists
		And   I cache the manufacturers count
		And   I am on the new manufacturer page
		When  I fill in "name" with "Commodore"
		And   I press "create"
		Then  I should see "Name has already been taken"
		And   a new manufacturer should not exist
		
	Scenario: Updating Manufacturer
		Given a manufacturer named "Apple" exists
		And   I am on the manufacturers page
		When  I follow "edit"
		And   I fill in "Name" with "Olivetti"
		And   I press "update"
		Then  I should see "Manufacturer was successfully updated"
		And   I should be on the manufacturers page
		And   I should see "Olivetti"
		But   I should not see "Apple"
	
	Scenario: Destroying Manufacturer
		Given a manufacturer named "Atari" exists
		And   I am on the manufacturers page
		When  I follow "destroy"
		Then  I should see "Manufacturer was successfully destroyed"
		And   I should be on the manufacturers page
		And   I should not see "Atari"
		