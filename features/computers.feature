@focus
Feature: Manage Computers
	In order to show computers information
	As a logged user
	I want to manage computers data
	
	Background:
		Given I am logged in as user

	Scenario: Only logged user are allowed
		Given I am logged out
		When  I go to the computers page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Computers
		Given I have a computer named "Amiga 1000"
		When  I go to the computers page
		Then  I should see "Amiga 1000"
	
	Scenario: Create New Computer
		Given some basic data exists
		And   I am on the computers page
		And   I follow "new computer"
		When  I fill in "Name" with "Apple II"
		And   I select "Apple" from "Manufacturer"
		And   I select "personal" from "Computer"
		And   I press "Create"
		Then  I should see "Computer was successfully created"
	
	Scenario: Edit Computer
		Given I have a computer named "Amiga 1000"
		And   I am on the computers page
		And   I should see "Amiga 1000"
		When  I follow "Edit"
		And   I fill in "name" with "Amiga 2000"
		And   I press "Update"
		Then  I should see "Computer was successfully updated"
		And   I should be on the "Amiga 2000" editor page
		And   I should not see "Amiga 1000"
	
	Scenario: Destroy Computer
		Given I have a computer named "Atari 800"
		And   I am on the computers page
		And   I should see "Atari 800"
		When  I follow "destroy"
		Then  I should see "Computer was successfully destroyed"
		And   I should be on the computers page
		And   I should not see "Atari 800"
		