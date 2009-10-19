Feature: Storage Devices Management
	In order to give proper mass storage devices information
	As a logged user
	I want to manage storage devices
	
	Background:
		Given I am logged in
		And   I have entered some data for storage names, formats and sizes
		
		Scenario: Access is forbidden unless logged in
			Given I am logged out
			When  I go to the storage devices page
			Then  I should see "You must be logged in to access this page"
			
		Scenario: Storage Devices List Page
			When I go to the storage devices page
			Then I should see "Listing Storage Devices"
			And  I should see "Name"
			And  I should see "Format"
			And  I should see "Size"
			
		Scenario: Creating Storage Device
			Given I am on the storage devices page
			And   I follow "new storage device"
			When  I select "floppy disk drive" from "Name"
			And   I select "5.25 inches" from "Format"
			And   I select "360Kb" from "size"
			And   I press "create"
			Then  I should see "Storage device was successfully created"
			
		Scenario: Destroying Storage Device
			Given I am on the storage devices page
			And   a storage device "floppy-5.25 inches-360k" exists
			And   I am on the storage devices page
			When  I follow destroy
			Then  I should see "Storage device was successfully destroyed"
			And   I should be on the storage devices page
			And   I should not see "floppy"
			
		Scenario: Editing Storage Device
			Given a storage device "floppy-5.25 inches-360Kb" exists
			And   I am on the storage devices page
			When  I follow "edit"
			And   I select "3.5 inches" from "format"
			And   I select "720Kb" from "size"
			And   I press "Update"
			Then  I should see "Storage device was successfully updated"
			And   I should be on the storage devices page
			And   I should not see "5.25 inches"
			But   I should see "3.5 inches"