@focus
Feature: CPUs Management
	In order to have correct computer CPUs information
	As a logged user
	I want to manage CPU information
	
	Background:
		Given I am logged in as user
		And   some data exists for cpu names, bits, families, manufacturers
		And   a cpu "Motorola 68000 7.16Mhz 16bit 68K" exists
	
	Scenario: Listing CPUs Page
		When I go to the cpus page
		Then I should see "Name"
		And  I should see "Family"
		And  I should see "Motorola"
		And  I should see "68000"
		
	Scenario: Access is forbidden to logged out users
		Given I am logged out
		When  I go to the cpus page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Create new CPU
		Given I cache the cpus count
		And   I am on the cpus page
		When  I follow "new CPU"
		And   I select "MOS" from "Manufacturer"
		And   I select "6502" from "Name"
		And   I select "8bit" from "Bit"
		And   I select "65XX" from "Family"
		And   I fill in "Clock" with "1 Mhz" 
		And   I press "create"
		Then  I should see "CPU was successfully created"
		And   a new cpu has been created
			
		Scenario: Failed CPU Creation (name taken)
			Given I am on the new cpu page
			And   I cache the cpus count
			And   I select "68000" from "Name"
			And   I select "Motorola" from "Manufacturer"
			And   I select "16bit" from "Bit"
			And   I fill in "Clock" with "7.16Mhz"
			And   I press "create"
			Then  I should see "Cpu name has already been taken"
			And   a new cpu has not been created
		
		Scenario: Failed CPU Creation (blank fields)
			Given I am on the new cpu page
			When  I press "create"
			Then  I should see "Cpu bit can't be blank"
			And   I should see "Cpu name can't be blank"
			And   I should see "Manufacturer can't be blank"

		Scenario: Update CPU 
			Given I cache the cpus count
			And   I am on the cpus page
			When  I follow "edit"
			And   I select "6502" from "Name"
			And   I select "MOS" from "Manufacturer"
			And   I press "update"
			Then  I should see "CPU was successfully updated"
			And   I should be on the cpus page
			And   I should see "6502"
			But   I should not see "68000"
			
		Scenario: Failed Update CPU
			Given a cpu "Motorola 68000 8Mhz 16bit 68K" exists
			Given I am on the cpus page
			And   I follow "edit"
			When  I fill in "Clock" with "8Mhz"
			And   I press "update"
			Then  I should see "Cpu name has already been taken"
	
		Scenario: Destroy CPU
			Given I am on the cpus page
			When  I follow "destroy"
			Then  I should see "CPU was successfully destroyed"
			And   I should be on the cpus page
			And   I should not see "68000"
		
		Scenario: Failed CPU Destroy
			Given existing cpu is associated to a computer
			And   I am on the cpus page
			When  I follow "destroy"
			Then  I should see "Can't destroy: CPU still has associated computers"
			And   I should be on the cpus page
			And   I should see "68000"
			
			