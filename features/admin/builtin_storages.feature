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
			And  I should see "Name"
			And  I should see "Format"
			And  I should see "Size"
			
		Scenario: Creating Builtin Storages
			Given I am on the builtin storages page
			And   I follow "new builtin storage"
			When  I select "floppy disk" from "Name"
			And   I select "5.25 inches" from "Format"
			And   I select "1.2Mb" from "Size"
			And   I press "create"
			Then  I should see "Builtin storage was successfully created"
			
		Scenario: Failed Builtin Storage Creation (no storage name)
			Given I am on the new builtin storage page
			And   I press "create"
			Then  I should see "Storage name can't be blank"
			
		Scenario: Failed Builtin Storage Creation (duplicate data)
			Given a builtin storage "floppy disk - 3.5 inches - 720Kb" has been created
			When  I go to the new builtin storage page
			And   I select "floppy disk" from "Name"
			And   I select "3.5 inches" from "Format"
			And   I select "720Kb" from "Size"
			And   I press "create"
			Then  I should see "Storage name has already been taken"

		Scenario: Editing Builtin Storage
			Given a builtin storage "floppy disk - 5.25 inches - 360Kb" has been created
			And   I am on the builtin storages page
			When  I follow "edit"
			And   I select "3.5 inches" from "Format"
			And   I select "1.44Mb" from "Size"
			And   I press "Update"
			Then  I should see "Builtin storage was successfully updated"
			And   I should be on the builtin storages page
			And   I should not see "5.25 inches"
			But   I should see "3.5 inches"
			And   I should see "1.44Mb"
		
		Scenario: Destroying Builtin Storage
			Given a builtin storage "floppy-5.25 inches-360k" has been created
			And   I am on the builtin storages page
			When  I follow "destroy"
			Then  I should see "Builtin storage was successfully destroyed"
			And   I should be on the builtin storages page
			And   I should not see "floppy"
		
		Scenario: Failed Builtin Storage Destroy
			Given a builtin storage "floppy-5.25 inches-360k" is associated to a hardware
			And   I am on the builtin storages page
			When  I follow "destroy"
			Then  I should see "Can't destroy: storage still has some hardware associated"
			And   I should be on the builtin storages page
			And   I should see "floppy"
		
		Scenario: Search Builtin Storage
		Given a builtin storage "floppy-5.25 inches-360k" has been created
		Given a builtin storage "floppy disk - 3.5 inches - 720Kb" has been created
		And   I am on the builtin storages page
		When  I fill in "Keywords" with "3.5 inches"
		And   I press "find"
		Then  I should see "3.5 inches"
		But   I should not see "5.25 inches"
		
