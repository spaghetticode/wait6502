Feature: Manage Storage Sizes
	In order to enter complete storage devices info
	As a logged user
	I want to manage storage sizes
	
	Background:
		Given I am logged in as user
	
	Scenario: Storage Sizes Page is not accessible when logged out
		Given I am logged out
		When  I go to the storage sizes page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Storage Sizes
		Given a storage size named "360Kb" exists
		When  I go to the storage sizes page
		Then  I should see "Listing Storage Sizes"
		And   I should see "360Kb"
		
	Scenario: Successfull Storage Size Creation
		And   I am on the storage sizes page
		And   I follow "new storage size"
		When  I fill in "name" with "1.2Mb"
		And   I press "Create"
		Then  I should see "Storage size was successfully created"
		And   I should be on the storage sizes page
		And   I should see "1.2Mb"
		
	Scenario: Failing Storage Size Creation (no name)
		And   I cache the storage sizes count
		And   I am on the new storage size page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new storage size has not been created
	
	Scenario: Failing Storage Name Creation (name taken)
		And   a storage size named "880Kb" exists
		And   I cache the storage sizes count
		When  I go to the new storage size page
		And   I fill in "name" with "880Kb"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new storage size has not been created
		
	Scenario: Destroying Storage Name
		And   a storage size named "880k" exists
		And   I am on the storage sizes page
		And   I should see "880k"
		When  I press "destroy"
		Then  I should see "Storage size was successfully destroyed"
		And   I should be on the storage sizes page
		And   I should not see "880k"

	Scenario: Failed Storage Name destroy
		Given a storage size named "880K" is part of a builtin storage
		And   I am on the storage sizes page
		When  I press "destroy"
		Then  I should see "Can't destroy: storage size is part of a builtin storage"
		And   I should be on the storage sizes page
		And   I should see "880K"
	