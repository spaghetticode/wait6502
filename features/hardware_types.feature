Feature: Manage Hardware Types
	In order to enter complete hardware info
	As a logged user
	I want to manage hardware types
	
	Background:
		Given I am logged in as user
	
	Scenario: Hardware Types Page is not accessible when logged out
		Given I am logged out
		When  I go to the hardware types page
		Then  I should see "You must be logged in to access this page"
		
	Scenario: Listing Hardware Types
		Given a hardware type named "Portable Computer" exists
		When  I go to the hardware types page
		Then  I should see "Listing Hardware Types"
		And   I should see "Portable Computer"
		
	Scenario: Successfull Hardware Type Creation
		Given I cache the hardware types count
		And   I am on the hardware types page
		And   I follow "new hardware type"
		When  I fill in "name" with "Home Computer"
		And   I press "Create"
		Then  I should see "Hardware type was successfully created"
		And   a new hardware type has been created
		And   I should be on the hardware types page
		And   I should see "Home Computer"
		
	Scenario: Failing Hardware Type Creation (no name)
		Given I cache the hardware types count
		And   I am on the new hardware type page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new hardware type has not been created
	
	Scenario: Failing Hardware Type Creation (name taken)
		Given a hardware type named "Personal Computer" exists
		And   I cache the hardware types count
		When  I go to the new hardware type page
		And   I fill in "name" with "Personal Computer"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new hardware type has not been created
		
	Scenario: Destroying Hardware Type
		Given a hardware type named "Portable Computer" exists
		And   I am on the hardware types page
		And   I should see "Portable Computer"
		When  I follow "destroy"
		Then  I should see "Hardware type was successfully destroyed"
		And   I should be on the hardware types page
		And   I should not see "Portable Computer"
	
	Scenario: Failed Hardware Type Destroy (associated hardware)
		Given a hardware type named "Personal Computer" is associated to a hardware
		And   I am on the hardware types page
		When  I follow "destroy"
		Then  I should see "Can't destroy: hardware type still has associated hardware"
		And   I should be on the hardware types page
		And   I should see "Personal Computer"
		