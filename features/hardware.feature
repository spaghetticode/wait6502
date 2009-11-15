Feature: Manage Hardware
	In order to show hardware information
	As a logged user
	I want to manage hardware data
	
	Background:
		Given I am logged in as user

	Scenario: Only logged user are allowed
		Given I am logged out
		When  I go to the hardware page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Hardware
		Given I have a hardware named "Amiga 1000"
		When  I go to the hardware page
		Then  I should see "Amiga 1000"
	
	Scenario: Create New Hardware
		Given some basic data exists
		And   I am on the hardware page
		And   I follow "new hardware"
		When  I select "computer" from "Hardware category"
		And   I fill in "Name" with "Apple II"
		And   I select "Apple" from "Manufacturer"
		And   I select "personal computer" from "Hardware type"
		And   I press "Create"
		Then  I should see "Hardware was successfully created"
	
	Scenario: Edit Hardware
		Given I have a hardware named "Amiga 1000"
		And   I am on the hardware page
		When  I follow "Amiga 1000"
		And   I fill in "name" with "Amiga 2000"
		And   I press "Update"
		Then  I should see "Hardware was successfully updated"
		And   I should be on the "Amiga 2000" hardware editor page
		And   I should not see "Amiga 1000"
	
	Scenario: Destroy Hardware
		Given I have a hardware named "Atari 800"
		And   I am on the hardware page
		And   I should see "Atari 800"
		When  I follow "destroy"
		Then  I should see "Hardware was successfully destroyed"
		And   I should be on the hardware page
		And   I should not see "Atari 800"
		
	Scenario: Add CPU to Existing Hardware
		Given I have a hardware named "Atari 800"
		And   some data exists for cpu names, bits, families, manufacturers
		And   a cpu "MOS 6502 1Mhz 8bit" has been created
		And   I am on the "Atari 800" hardware editor page
		When  I select "MOS 6502 @1Mhz, 8bit  family" from "cpu_id"
		And   I press "Add CPU"
		Then  I should see "Cpu was successfully added"
		
	Scenario: Add co-CPU to Existing Hardware
		Given I have a hardware named "IBM PC"
		And   some co cpu names and types and families and manufacturers exist
		And   a co cpu "Intel 8087 Math" has been created
		And   I am on the "IBM PC" hardware editor page
		When  I select "Intel 8087 Math co-processor" from "co_cpu_id"
		And   I press "Add CO CPU"
		Then  I should see "Co cpu was successfully added"
		
	Scenario: Add Builtin Storage to Existing Hardware
		Given I have a hardware named "IBM PC"
		And   I have entered some data for storage names, formats and sizes
		And   a builtin storage "floppy disk - 5.25 inches - 360Kb" has been created
		And   I am on the "IBM PC" hardware editor page
		When  I select "floppy disk 5.25 inches 360Kb" from "builtin_storage_id"
		And   I press "Add BUILTIN STORAGE"
		Then  I should see "Builtin storage was successfully added"
	
	Scenario: Add Operative System to Existing Hardware
		Given I have a hardware named "Amiga 1000"
		And   a operative system named "Amiga DOS" exists
		And   I am on the "Amiga 1000" hardware editor page
		When  I select "Amiga DOS" from "operative_system_id"
		And   I press "Add OPERATIVE SYSTEM"
		Then  I should see "Operative system was successfully added"
	
	Scenario: Add I/O Port to Existing Hardware
		Given  I have a hardware named "Amiga 1000"
		And    a io port named "Disk Drive" exists
		And    I am on the "Amiga 1000" hardware editor page
		When   I select "Disk Drive ( connector)" from "io_port_id"
		And    I press "Add IO PORT"
		Then   I should see "Io port was successfully added"
		
	Scenario: Add Original Sale Price to Existing Hardware
		Given  I have a hardware named "Amiga 2000"
		And    some currencies and countries exist
		And    I am on the "Amiga 2000" hardware editor page
		When   I select "Italy" from "original_price_country_id"
		And    I select "EUR" from "original_price_currency_id"
		And    I fill in "original_price_amount" with "2'500'000"
		And    I press "Add Price"
		Then   I should see "Original Price was successfully created"

	Scenario: Computers List
		Given the following hardware exists:
			| name      | manufacturer| category  |
			| Amiga 1000| Commodore   | computer  |
			| DuoDisk   | Apple       | peripheral|
		And   I am on the hardware page
		When  I follow "computers"
		Then  I should see "Listing Computers"
		And   I should see "Amiga 1000"
		But   I should not see "DuoDisk"

	Scenario: Peripherals List
		Given the following hardware exists:
			| name      | manufacturer| category  |
			| Amiga 1000| Commodore   | computer  |
			| DuoDisk   | Apple       | peripheral|
		And   I am on the hardware page
		When  I follow "peripherals"
		Then  I should see "Listing Peripherals"
		And   I should see "DuoDisk"
		But   I should not see "Amiga 1000"
		
	Scenario: Hardware Search
		Given the following computers exist:
			| name      | manufacturer|
			| Amiga 1000| Commodore   |
			| Apple IIe | Apple       |
		And  I am on the hardware page
		When I fill in "Keywords" with "Amiga"
		And  I press "find"
		Then I should see "Amiga 1000"
		But  I should not see "Apple IIe"
