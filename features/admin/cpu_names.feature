Feature: Manage CPU Names
	In order to enter complete CPU info
	As a logged user
	I want to manage CPU names
	
	Background:
		Given I am logged in as user
	
	Scenario: CPU Names Page is not accessible when logged out
		Given I am logged out
		When  I go to the cpu names page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing CPU Names
		Given a cpu name named "68000" exists
		When  I go to the cpu names page
		Then  I should see "Listing CPU Names"
		And   I should see "68000"
		
	Scenario: Successfull CPU Name Creation
		Given I am on the cpu names page
		And   I follow "new cpu name"
		When  I fill in "name" with "8086"
		And   I press "Create"
		Then  I should see "CPU name was successfully created"
		And   I should be on the cpu names page
		And   I should see "8086"
		
	Scenario: Failing CPU Name Creation (no name)
		Given I cache the cpu names count
		And   I am on the new cpu name page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new cpu name has not been created
	
	Scenario: Failing CPU Name Creation (name taken)
		Given a cpu name named "8086" exists
		And   I cache the cpu names count
		When  I go to the new cpu name page
		And   I fill in "name" with "8086"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new cpu name has not been created
		
	Scenario: Destroying CPU Name
		Given a cpu name named "6502" exists
		And   I am on the cpu names page
		And   I should see "6502"
		When  I press "destroy"
		Then  I should see "CPU name was successfully destroyed"
		And   I should be on the cpu names page
		And   I should not see "6502"
		
	Scenario: Failed CPU Name Destroy
		Given a cpu name named "68000" is part of a CPU
		And   I am on the cpu names page
		And   I should see "68000"
		When  I press "destroy"
		Then  I should see "Can't destroy: CPU name is part of CPU"
		And   I should be on the cpu names page
		And  I should see "68000"
