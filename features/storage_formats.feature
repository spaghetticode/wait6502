Feature: Manage Storage Formats
	In order to enter complete storage devices info
	As a logged user
	I want to manage storage formats
	
	Background:
		Given I am logged in as user
	
	Scenario: Storage Formats Page is not accessible when logged out
		Given I am logged out
		When  I go to the storage formats page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Storage Formats
		Given a storage format named "3.5 inches" exists
		When  I go to the storage formats page
		Then  I should see "Listing Storage Formats"
		And   I should see "3.5 inches"
		
	Scenario: Successfull Storage Format Creation
		Given I am on the storage formats page
		And   I follow "new storage format"
		When  I fill in "name" with "3.5 inches"
		And   I press "Create"
		Then  I should see "Storage format was successfully created"
		And   I should be on the storage formats page
		And   I should see "3.5 inches"
		
	Scenario: Failing Storage Format Creation (no name)
		Given I cache the storage formats count
		And   I am on the new storage format page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new storage format has not been created
	
	Scenario: Failing Storage Format Creation (name taken)
		Given a storage format named "3.5 inches" exists
		And   I cache the storage formats count
		When  I go to the new storage format page
		And   I fill in "name" with "3.5 inches"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new storage format has not been created
		
	Scenario: Destroying Storage Format
		Given a storage format named "3.5 inches" exists
		And   I am on the storage formats page
		When  I press "destroy"
		Then  I should see "Storage format was successfully destroyed"
		And   I should be on the storage formats page
		And   I should not see "3.5 inches"
