@focus
Feature: Manage co-CPU
	In order to add correct co-cpu information
	As a logged user
	I want to manage co-CPUs
	
	Background:
		Given I am logged in as user
		And   some co cpu names and types and families and manufacturers exist
		
		Scenario: Access is restricted
			Given I am logged out
			When  I go to the co cpus page
			Then  I should see "You must be logged in to access this page"
		
		Scenario: listing co-CPUs
			Given a co cpu "Intel 8087 Math" has been created
			When I go to the co cpus page
			Then I should see "8087"
			And  I should see "Math"
		
		Scenario: Create co-CPU
			Given I am on the co cpus page
			And   I cache the co cpus count
			When  I follow "new co cpu"
			And   I select "CSG" from "Manufacturer"
			And   I select "Paula" from "Name"
			And   I select "Audio" from "Type"
			And   I select "X86" from "CPU Family"
			And   I press "create"
			Then  I should see "Co CPU was successfully created"
			And   I should be on the co cpus page
			And   a new co cpu has been created
			
		Scenario: Failed co-CPU Creation (no name)
			Given I am on the new co cpu page
			And   I cache the co cpus count
			And   I select "Intel" from "Manufacturer"
			And   I select "Audio" from "Type"
			And   I press "create"
			Then  I should see "Co cpu name can't be blank"
			And   a new co cpu has not been created
			
		Scenario: Failed co-CPU Creation (no manufacturer)
			Given I am on the new co cpu page
			And   I select "8087" from "Name"
			And 	I select "Math" from "Type"
			And   I press "create"
			Then  I should see "Manufacturer can't be blank"

		Scenario: Failed co-CPU Creation (no type)
			Given I am on the new co cpu page
			And   I select "8087" from "Name"
			And 	I select "Intel" from "Manufacturer"
			And   I press "create"
			Then  I should see "Co cpu type can't be blank"
						
		Scenario: Failed co-CPU Creation (name taken)
			Given a co cpu "Intel 8087 Math" has been created
			And   I am on the new co cpu page
			When  I select "Intel" from "Manufacturer"
			And   I select "8087" from "Name"
			And   I select "Audio" from "Type"
			And   I press "create"
			Then  I should see "Co cpu name has already been taken"
			
		Scenario: Update co-CPU
			Given a co cpu "Intel Paula Math" has been created
			And   I am on the co cpus page
			When  I follow "edit"
			And   I select "8087" from "Name"
			And   I press "update"
			Then  I should see "Co-CPU was successfully updated"
			And   I should be on the co cpus page
			And   I should see "8087"
			But   I should not see "Paula"
		
		Scenario: Failed co-CPU Update
			Given a co cpu "CSG 8087 Audio" has been created
			And   a co cpu "CSG Paula Audio" has been created
			And   I am on the co cpus page
			When  I follow "edit"
			And   I select "Paula" from "Name"
			And   I press "update"
			Then  I should see "Co cpu name has already been taken"
			
		Scenario: Destroy co-CPU
			Given a co cpu "Intel 8087 Math" has been created
			And   I am on the co cpus page
			And   I should see "8087"
			When  I follow "destroy"
			Then  I should see "Co-CPU was successfully destroyed"
			And   I should be on the co cpus page
			And   I should not see "8087"
			
		Scenario: Failed Co-CPU Destroy
			Given a co cpu "Intel 8087 Math" is associated to a hardware
			And   I am on the co cpus page
			When  I follow "destroy"
			Then  I should see "Can't destroy: co-CPU still has some hardware associated"
			And   I should be on the co cpus page
			And   I should see "8087"
		
		Scenario: Search co-CPU
			Given a co cpu "Intel 8087 Math" has been created
			And   a co cpu "CSG Paula Math" has been created
			And   I am on the co cpus page
			When  I fill in "Keywords" with "8087"
			And   I press "find"
			Then  I should see "8087"
			But   I should not see "Paula"
			