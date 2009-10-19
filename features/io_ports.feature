Feature: Manage I/O Ports
	In order to add computer io ports information
	As a logged in user
	I want to manage io ports
	
	Background:
		Given I am logged in as user
		
	Scenario: IO Ports List Page is not accessible when logged out
		Given I am logged out
		When  I go to the io ports page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing IO Ports
		When  I go to the io ports page
		Then  I should see "Listing IO Ports"
		And   I should see "Name"
		And   I should see "Connector"

	Scenario: Creating New IO Port
		Given I am on the io ports page
		And   I cache the io ports count
		And   I follow "new io port"
		When  I fill in "name" with "parallel"
		And   I fill in "connector" with "centronics"
		And   I press "create"
		Then  I should see "IO Port was successfully created"
		And   I should be on the io ports page
		And   a new io port has been created	
		
	Scenario: Failed New IO Port Creation
		Given a io port with name "parallel" and connector "centronics" exists
		And   I am on the new io port page
		And   I cache the io port count
		When  I fill in "name" with "parallel"
		And   I fill in "connector" with "centronics"
		And   I press "create"
		Then  I should see "Name has already been taken"
		And   a new io port has not been created
		
	Scenario: Updating IO Port
		Given a io port with name "serial" and connector "rs232" exists
		When  I go to the io ports page
		And   I follow "edit"
		And   I fill in "connector" with "din 8 pin"
		And   I press "update"
		Then  I should see "IO Port was successfully updated"
		And   I should be on the io ports page
		And   I should see "din 8 pin"
		
	Scenario: Destroying IO Port
		Given a io port with name "serial" and connector "rs232" exists
		When  I go to the io ports page
		And   I follow "destroy"
		Then  I should see "IO Port was successfully destroyed"
		And   I should be on the io ports page
		And   I should not see "rs232"