Feature: Builtin Storages Management
	In order to give proper builtin mass storage devices information
	As a logged user
	I want to manage builtin storage devices
	
	Background:
		Given I am logged in as user
		And   I have entered some data for storage names, formats and sizes
		
		Scenario: Access is forbidden unless logged in
			Given I am logged out
			When  I go to the builtin storages page
			Then  I should see "You must be logged in to access this page"
			
		Scenario: Builtin Storages List Page
			When I go to the storage devices page
			Then I should see "Listing Builtin Storages"
			And  I should see "Name"
			And  I should see "Format"
			And  I should see "Size"
			
		Scenario: Creating Builtin Storages
			Given I am on the builtin storages page
			And   I follow "new builtin storage"
			When  I select "floppy disk drive" from "Name"
			And   I select "5.25 inches" from "Format"
			And   I select "1.2Mb" from "size"
			And   I press "create"
			Then  I should see "Builtin Storage was successfully created"
			
		Scenario: Destroying Builtin Storage
			Given a builtin storage "floppy-5.25 inches-360k" exists
			And   I am on the builtin storages page
			When  I follow "destroy"
			Then  I should see "Builtin storage was successfully destroyed"
			And   I should be on the builtin storages page
			And   I should not see "floppy"
			
		Scenario: Editing Builtin Storage
			Given a builtin storage "floppy-5.25 inches-360Kb" exists
			And   I am on the builtin storage page
			When  I follow "edit"
			And   I select "3.5 inches" from "format"
			And   I select "1.44Mb" from "size"
			And   I press "Update"
			Then  I should see "Builtin storage was successfully updated"
			And   I should be on the storage devices page
			And   I should not see "5.25 inches"
			But   I should see "3.5 inches"
			And   I should see "1.44Mb"
			