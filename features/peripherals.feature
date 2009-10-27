Feature: Manage Peripherals
	In order to show peripherals information
	As a logged user
	I want to manage peripherals data
	
	Background:
		Given I am logged in as user

	Scenario: Only logged user are allowed
		Given I am logged out
		When  I go to the peripherals page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Peripherals
		Given I have a peripheral named "DuoDisk"
		When  I go to the peripherals page
		Then  I should see "DuoDisk"
	
	Scenario: Create New Peripheral
		Given some basic data exists
		And   I am on the peripherals page
		And   I follow "new peripheral"
		When  I fill in "Name" with "Silent Type"
		And   I select "Apple" from "Manufacturer"
		And   I select "printer" from "peripheral type"
		And   I press "Create"
		Then  I should see "Peripheral was successfully created"
	
	Scenario: Edit Computer
		Given I have a peripheral named "Silent Type"
		And   I am on the peripherals page
		And   I should see "Silent Type"
		When  I follow "Edit"
		And   I fill in "name" with "DuoDisk"
		And   I press "Update"
		Then  I should see "Peripheral was successfully updated"
		And   I should be on the "DuoDisk" peripheral editor page
		And   I should not see "Silent Type"
	
	Scenario: Destroy Computer
		Given I have a peripheral named "Printer"
		And   I am on the peripherals page
		And   I should see "Printer"
		When  I follow "destroy"
		Then  I should see "Peripheral was successfully destroyed"
		And   I should be on the peripherals page
		And   I should not see "Printer"
