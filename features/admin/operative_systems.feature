Feature: Manage Opertive Systems
	In order to add OS info to hardwares
	As a logged user
	I want to manage operative systems

	Background:
		Given I am logged in as user
	
	Scenario: OS Page is not accessible when logged out
		Given I am logged out
		When  I go to the operative systems page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing OSes
		Given a operative system named "CP/M" exists
		When  I go to the operative systems page
		Then  I should see "Listing Operative Systems"
		And   I should see "CP/M"
		
	Scenario: Successfull OS Creation
		Given I am on the operative systems page
		And   I follow "new operative system"
		When  I fill in "name" with "AmigaDOS"
		And   I press "Create"
		Then  I should see "Operative system was successfully created"
		And   I should be on the operative systems page
		And   I should see "AmigaDOS"
		
	Scenario: Failing OS Creation (no name)
		Given I cache the operative systems count
		And   I am on the new operative system page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new operative system has not been created
	
	Scenario: Failing OS Creation (name taken)
		Given a operative system named "MS-DOS" exists
		And   I cache the operative systems count
		When  I go to the new operative system page
		And   I fill in "name" with "MS-DOS"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new operative system has not been created
		
	Scenario: Updating OS
		Given a operative system named "AmigaDOS" exists
		And   I am on the operative systems page
		When  I follow "edit"
		And   I fill in "name" with "ProDOS"
		And   I press "Update"
		Then  I should see "Operative system was successfully updated."
		And   I should be on the operative systems page
		And   I should see "ProDOS"
		
	Scenario: Failed OS Update
		Given a operative system named "ProDOS" exists
		And   a operative system named "AmigaDOS" exists
		And   I am on the operative systems page
		When  I follow "edit"
		And   I fill in "name" with "ProDos"
		And   I press "Update"
		Then  I should see "Name has already been taken"
		
	Scenario: Destroying OS
		Given a operative system named "OSX" exists
		And   I am on the operative systems page
		And   I should see "OSX"
		When  I follow "destroy"
		Then  I should see "Operative system was successfully destroyed"
		And   I should be on the operative systems page
		And   I should not see "OSX"

	Scenario: Failed IO Port Destroy
		Given a operative system named "MS-DOS" has a hardware associated
		And   I am on the operative systems page
		When  I follow "destroy"
		Then  I should see "Can't destroy: operative system still has some hardware associated"
		And   I should be on the operative systems page
		And   I should see "MS-DOS"
		