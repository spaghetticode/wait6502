Feature: Manage Opertive Systems
	In order to add OS info to computers
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
		And   I am on the operative systems page
		And   I follow "new operative system"
		When  I fill in "name" with "AmigaDOS"
		And   I press "Create"
		Then  I should see "Operative system was successfully created"
		And   I should be on the operative systems page
		And   I should see "AmigaDOS"
		
	Scenario: Failing OS Creation (no name)
		And   I cache the operative systems count
		And   I am on the new operative system page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new operative system has not been created
	
	Scenario: Failing OS Creation (name taken)
		And   a operative system named "MS-DOS" exists
		And   I cache the operative systems count
		When  I go to the new operative system page
		And   I fill in "name" with "MS-DOS"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new operative system has not been created
		
	Scenario: Destroying OS
		And   a operative system named "OSX" exists
		And   I am on the operative systems page
		And   I should see "OSX"
		When  I press "destroy"
		Then  I should see "Operative system was successfully destroyed"
		And   I should be on the operative systems page
		And   I should not see "OSX"