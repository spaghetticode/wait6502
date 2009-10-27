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
		And   I should be on the "Amiga 2000" computer editor page
		And   I should not see "Amiga 1000"
	
	Scenario: Destroy Computer
		Given I have a computer named "Atari 800"
		And   I am on the computers page
		And   I should see "Atari 800"
		When  I follow "destroy"
		Then  I should see "Computer was successfully destroyed"
		And   I should be on the computers page
		And   I should not see "Atari 800"
		
	Scenario: Add CPU to Existing Computer
		Given I have a computer named "Atari 800"
		And   some data exists for cpu names, bits, families, manufacturers
		And   a cpu "MOS 6502 1Mhz 8bit" exists
		And   I am on the "Atari 800" computer editor page
		When  I select "MOS 6502 @1Mhz, 8bit  family" from "cpu_id"
		And   I press "Add CPU"
		Then  I should see "Cpu was successfully added"
		
	Scenario: Add co-CPU to Existing Computer
		Given I have a computer named "IBM PC"
		And   some co cpu names and types and manufacturers exist
		And   a co cpu "Intel 8087 Math" exists
		And   I am on the "IBM PC" computer editor page
		When  I select "Intel 8087 Math co-processor" from "co_cpu_id"
		And   I press "Add CO CPU"
		Then  I should see "Co cpu was successfully added"
		
	Scenario: Add Builtin Storage to Existing Computer
		Given I have a computer named "IBM PC"
		And   I have entered some data for storage names, formats and sizes
		And   a builtin storage "floppy disk - 5.25 inches - 360Kb" exists
		And   I am on the "IBM PC" computer editor page
		When  I select "floppy disk 5.25 inches 360Kb" from "builtin_storage_id"
		And   I press "Add BUILTIN STORAGE"
		Then  I should see "Builtin storage was successfully added"
	
	Scenario: Add Operative System to Existing Computer
		Given I have a computer named "Amiga 1000"
		And   a operative system named "Amiga DOS" exists
		And   I am on the "Amiga 1000" computer editor page
		When  I select "Amiga DOS" from "operative_system_id"
		And   I press "Add OPERATIVE SYSTEM"
		Then  I should see "Operative system was successfully added"
	
	Scenario: Add I/O Port to Existing Computer
		Given  I have a computer named "Amiga 1000"
		And    a io port named "Disk Drive" exists
		And    I am on the "Amiga 1000" computer editor page
		When   I select "Disk Drive ( connector)" from "io_port_id"
		And    I press "Add IO PORT"
		Then   I should see "Io port was successfully added"
		
		