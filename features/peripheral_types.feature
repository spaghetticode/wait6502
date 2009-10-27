Feature: Manage Peripheral Types
	In order to enter complete computer info
	As a logged user
	I want to manage peripheral types
	
	Background:
		Given I am logged in as user
	
	Scenario: Peripheral Types Page is not accessible when logged out
		Given I am logged out
		When  I go to the peripheral types page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Peripheral Types
		Given a peripheral type named "Printer" exists
		When  I go to the peripheral types page
		Then  I should see "Listing Peripheral Types"
		And   I should see "Printer"
		
	Scenario: Successfull Peripheral Type Creation
		Given I cache the peripheral types count
		And   I am on the peripheral types page
		And   I follow "new peripheral type"
		When  I fill in "name" with "Printer"
		And   I press "Create"
		Then  I should see "Peripheral type was successfully created"
		And   a new peripheral type has been created
		And   I should be on the peripheral types page
		And   I should see "Printer"
		
	Scenario: Failing Peripheral Type Creation (no name)
		Given I cache the peripheral types count
		And   I am on the new peripheral type page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new peripheral type has not been created
	
	Scenario: Failing Peripheral Type Creation (name taken)
		Given a peripheral type named "Monitor" exists
		And   I cache the peripheral types count
		When  I go to the new peripheral type page
		And   I fill in "name" with "Monitor"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new peripheral type has not been created
		
	Scenario: Destroying Peripheral Type
		Given a peripheral type named "Monitor" exists
		And   I am on the peripheral types page
		And   I should see "Monitor"
		When  I follow "destroy"
		Then  I should see "Peripheral type was successfully destroyed"
		And   I should be on the peripheral types page
		And   I should not see "Monitor"

	Scenario: Failed Peripheral Type Destroy (associated peripheral)
		Given a peripheral type named "modem" is associated to a peripheral
		And   I am on the peripheral types page
		When  I follow "destroy"
		Then  I should see "Can't destroy: peripheral type still has associated peripherals"
		And   I should be on the peripheral types page
		And   I should see "modem"
