Feature: Manage Co-CPU Names
	In order to enter complete CPU info
	As a logged user
	I want to manage CPU families names
	
	Background:
		Given I am logged in as user
	
	Scenario: Co-CPU Names Page is not accessible when logged out
		Given I am logged out
		When  I go to the co cpu names page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Co-CPU Names
		Given a co cpu name exists with name: "Intel 8087"
		When  I go to the co cpu names page
		Then  I should see "Listing Co-CPU Names"
		And   I should see "Intel 8087"
		
	Scenario: Successfull Co-CPU Name Creation
		Given I am on the co cpu names page
		And   I follow "new co cpu name"
		When  I fill in "name" with "Fat Agnus"
		And   I press "Create"
		Then  I should see "Co-CPU name was successfully created"
		And   I should be on the co cpu names page
		And   I should see "Fat Agnus"
		
	Scenario: Failing Co-CPU Name Creation (no name)
		Given I cache the co cpu names count
		And   I am on the new co cpu name page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new co cpu name has not been created
	
	Scenario: Failing Co-CPU Name Creation (name taken)
		Given a co cpu name exists with name: "68881"
		And   I cache the co cpu names count
		When  I go to the new co cpu name page
		And   I fill in "name" with "68881"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new co cpu name has not been created
		
	Scenario: Destroying Co-CPU Name
		Given a co cpu name exists with name: "8087"
		And   I am on the co cpu names page
		And   I should see "8087"
		When  I press "destroy"
		Then  I should see "Co-CPU name was successfully destroyed"
		And   I should be on the co cpu names page
		And   I should not see "8087"
		
	Scenario: Failied Co-CPU Name Destroy
		Given some co cpu names and types and manufacturers exist
		And   a co cpu "Intel 8087 Math" has been created
		And	  I am on the co cpu names page
		And   I should see "8087"
		When  I press "destroy"
		Then  I should see "Can't destroy: co-CPU name is part of a co-CPU"
		And   I should be on the co cpu names page
		And   I should see "8087"