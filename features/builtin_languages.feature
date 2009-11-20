Feature: Manage Builtin Languages
	In order to enter complete computer language info
	As a logged user
	I want to manage builtin languages
	
	Background:
		Given I am logged in as user
	
	Scenario: Builtin Languages Page is not accessible when logged out
		Given I am logged out
		When  I go to the builtin languages page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Builtin Languages
		Given a builtin language named "BASIC" exists
		When  I go to the builtin languages page
		Then  I should see "Listing Builtin Languages"
		And   I should see "BASIC"
		
	Scenario: Successfull Builtin Language Creation
		Given I am on the builtin languages page
		And   I follow "new builtin language"
		When  I fill in "name" with "Basic"
		And   I press "Create"
		Then  I should see "Builtin language was successfully created"
		And   I should be on the builtin languages page
		And   I should see "Basic"
		
	Scenario: Failing Builtin Language Creation (no name)
		Given I cache the builtin languages count
		And   I am on the new builtin language page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new builtin language has not been created
	
	Scenario: Failing Builtin Language Creation (name taken)
		Given a builtin language named "BASIC" exists
		And   I cache the builtin languages count
		When  I go to the new builtin language page
		And   I fill in "name" with "BASIC"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new builtin language has not been created
		
	Scenario: Destroying Builtin Language
		Given a builtin language named "BASIC" exists
		And   I am on the builtin languages page
		And   I should see "BASIC"
		When  I follow "destroy"
		Then  I should see "Builtin language was successfully destroyed"
		And   I should be on the builtin languages page
		And   I should not see "BASIC"

	Scenario: Failed Builtin Language Destroy
		Given a builtin language named "BASIC" is associated to a hardware
		And   I am on the builtin languages page
		When  I follow "destroy"
		Then  I should see "Can't destroy: language still has some hardware associated"
		And   I should be on the builtin languages page
		And   I should see "BASIC"
