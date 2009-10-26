Feature: Manage Storage Names
	In order to enter complete storage devices info
	As a logged user
	I want to manage storage names
	
	Background:
		Given I am logged in as user
	
	Scenario: Storage Names Page is not accessible when logged out
		Given I am logged out
		When  I go to the storage names page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Storage Names
		Given a storage name named "floppy disk" exists
		When  I go to the storage names page
		Then  I should see "Listing Storage Names"
		And   I should see "floppy disk"
		
	Scenario: Successfull Storage Name Creation
		And   I am on the storage names page
		And   I follow "new storage name"
		When  I fill in "name" with "hard disk"
		And   I press "Create"
		Then  I should see "Storage name was successfully created"
		And   I should be on the storage names page
		And   I should see "hard disk"
		
	Scenario: Failing Storage Name Creation (no name)
		And   I cache the storage names count
		And   I am on the new storage name page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new storage name has not been created
	
	Scenario: Failing Storage Name Creation (name taken)
		And   a storage name named "tape" exists
		And   I cache the storage names count
		When  I go to the new storage name page
		And   I fill in "name" with "tape"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new storage name has not been created
		
	Scenario: Destroying Storage Name
		And   a storage name named "tape" exists
		And   I am on the storage names page
		And   I should see "tape"
		When  I follow "destroy"
		Then  I should see "Storage name was successfully destroyed"
		And   I should be on the storage names page
		And   I should not see "tape"

	Scenario: Failed Storage Name Destroy
		Given a storage name named "floppy" is part of a builtin storage
		And   I am on the storage names page
		And   I follow "destroy"
		Then  I should see "Can't destroy: storage name is part of a builtin storage"
		And   I should be on the storage names page
		And   I should see "floppy"
		