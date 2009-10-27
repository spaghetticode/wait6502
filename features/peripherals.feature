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

	Scenario: Add I/O Port to Existing Peripheral
		Given  I have a peripheral named "Silent Type"
		And    a io port named "serial" exists
		And    I am on the "Silent Type" peripheral editor page
		When   I select "serial ( connector)" from "io_port_id"
		And    I press "Add IO PORT"
		Then   I should see "Io port was successfully added"

	Scenario: Add Builtin Storage to Existing Peripheral
		Given I have a peripheral named "DuoDisk"
		And   I have entered some data for storage names, formats and sizes
		And   a builtin storage "floppy disk - 5.25 inches - 360Kb" exists
		And   I am on the "DuoDisk" peripheral editor page
		When  I select "floppy disk 5.25 inches 360Kb" from "builtin_storage_id"
		And   I press "Add BUILTIN STORAGE"
		Then  I should see "Builtin storage was successfully added"

	Scenario: Add Original Sale Price to Existing Peripheral
		Given  I have a peripheral named "DuoDisk"
		And    some currencies and countries exist
		And    I am on the "DuoDisk" peripheral editor page
		When   I select "Italy" from "original_price_country_id"
		And    I select "£" from "original_price_currency_id"
		And    I fill in "original_price_amount" with "990'000"
		And    I press "Add Price"
		Then   I should see "Original Price was successfully created"