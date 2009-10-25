Feature: Manage Computer Types
	In order to enter complete computer info
	As a logged user
	I want to manage computer types
	
	Background:
		Given I am logged in as user
	
	Scenario: Computer Types Page is not accessible when logged out
		Given I am logged out
		When  I go to the computer types page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Computer Types
		Given a computer type named "Portable" exists
		When  I go to the computer types page
		Then  I should see "Listing Computer Types"
		And   I should see "Portable"
		
	Scenario: Successfull Computer Type Creation
		Given I cache the computer types count
		And   I am on the computer types page
		And   I follow "new computer type"
		When  I fill in "name" with "Home Computer"
		And   I press "Create"
		Then  I should see "Computer type was successfully created"
		And   a new computer type has been created
		And   I should be on the computer types page
		And   I should see "Home Computer"
		
	Scenario: Failing Computer Type Creation (no name)
		Given I cache the computer types count
		And   I am on the new computer type page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new computer type has not been created
	
	Scenario: Failing Computer Type Creation (name taken)
		Given a computer type named "Personal" exists
		And   I cache the computer types count
		When  I go to the new computer type page
		And   I fill in "name" with "Personal"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new computer type has not been created
		
	Scenario: Destroying Computer Type
		Given a computer type named "Portable" exists
		And   I am on the computer types page
		And   I should see "Portable"
		When  I follow "destroy"
		Then  I should see "Computer type was successfully destroyed"
		And   I should be on the computer types page
		And   I should not see "Portable"
	
	Scenario: Failed Computer Type Destroy (associated computer)
		Given a computer type named "Portable" is associated to a computer
		And   I am on the computer types page
		When  I follow "destroy"
		Then  I should see "Can't destroy: computer type still has associated computers"
		And   I should be on the computer types page
		And   I should see "Portable"
		