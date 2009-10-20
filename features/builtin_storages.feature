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
			When I go to the builtin storages page
			Then I should see "Listing Builtin Storages"
			And  I should see "Storage name"
			And  I should see "Storage format"
			And  I should see "Storage size"
			
		Scenario: Creating Builtin Storages
			Given I am on the builtin storages page
			And   I follow "new builtin storage"
			When  I select "floppy disk" from "Storage name"
			And   I select "5.25 inches" from "Storage format"
			And   I select "1.2Mb" from "Storage size"
			And   I press "create"
			Then  I should see "Builtin storage was successfully created"
			
		Scenario: Failed Builtin Storage Creation (no storage name)
			Given I am on the new builtin storage page
			And   I press "create"
			Then  I should see "Storage name can't be blank"
			
		Scenario: Failed Builtin Storage Creation (duplicate data)
			Given a builtin storage "floppy disk - 3.5 inches - 720Kb" exists
			When  I go to the new builtin storage page
			And   I select "floppy disk" from "Storage name"
			And   I select "3.5 inches" from "Storage format"
			And   I select "720Kb" from "Storage size"
			And   I press "create"
			Then  I should see "Storage name has already been taken"
			
		Scenario: Destroying Builtin Storage
			Given a builtin storage "floppy-5.25 inches-360k" exists
			And   I am on the builtin storages page
			When  I follow "destroy"
			Then  I should see "Builtin storage was successfully destroyed"
			And   I should be on the builtin storages page
			And   I should not see "floppy"
			
		Scenario: Editing Builtin Storage
			Given a builtin storage "floppy disk - 5.25 inches - 360Kb" exists
			And   I am on the builtin storages page
			When  I follow "edit"
			And   I select "3.5 inches" from "Storage format"
			And   I select "1.44Mb" from "Storage size"
			And   I press "Update"
			Then  I should see "Builtin storage was successfully updated"
			And   I should be on the builtin storages page
			And   I should not see "5.25 inches"
			But   I should see "3.5 inches"
			And   I should see "1.44Mb"
				