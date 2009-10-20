Feature: Manage CPU Families
	In order to enter complete CPU info
	As a logged user
	I want to manage CPU families names
	
	Background:
		Given I am logged in as user
	
	Scenario: CPU Families Page is not accessible when logged out
		Given I am logged out
		When  I go to the cpu families page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing CPU Families
		Given a cpu family named "68K" exists
		When  I go to the cpu families page
		Then  I should see "Listing CPU Families"
		And   I should see "68K"
		
	Scenario: Successfull CPU Family Creation
		And   I am on the cpu families page
		And   I follow "new cpu family"
		When  I fill in "name" with "X86"
		And   I press "Create"
		Then  I should see "CPU family was successfully created"
		And   I should be on the cpu families page
		And   I should see "X86"
		
	Scenario: Failing CPU Family Creation (no name)
		And   I cache the cpu families count
		And   I am on the new cpu family page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new cpu family has not been created
	
	Scenario: Failing Storage Name Creation (name taken)
		And   a cpu family named "X86" exists
		And   I cache the cpu families count
		When  I go to the new cpu family page
		And   I fill in "name" with "X86"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new cpu family has not been created
		
	Scenario: Destroying Storage Name
		And   a cpu family named "65XX" exists
		And   I am on the cpu families page
		And   I should see "65XX"
		When  I press "destroy"
		Then  I should see "CPU family was successfully destroyed"
		And   I should be on the cpu families page
		And   I should not see "65XX"
