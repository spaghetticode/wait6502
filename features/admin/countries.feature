Feature: Manage Countries
	In order to mantain correct geographical data
	As a logged user
	I want to manage countries
	
	Background:
		Given I am logged in as user
		
	Scenario: Listing Countries
		Given a country named "Italy" exists
		When  I go to the countries page
		Then  I should see "Listing Countries"
		And   I should see "Italy"

	Scenario: Successfull Country Creation (no flag)
		Given I cache the countries count
		And   I am on the countries page
		And   I follow "new country"
		When  I fill in "name" with "Italy"
		And   I press "Create"
		Then  I should see "Country was successfully created"
		And   a new country has been created
		And   I should be on the countries page
		And   I should see "Italy"
		
	Scenario: Successfull Country Creation (with flag)
		Given I cache the countries count
		And   I am on the countries page
		And   I follow "new country"
		When  I fill in "name" with "Italy"
		And   I attach the file at "public/images/rails.png" to "flag" 
		And   I press "Create"
		Then  I should see "Country was successfully created"
		And   a new country has been created
		And   I should be on the countries page
		And   I should see "Italy"
			
	Scenario: Failing Country Creation (no name)
		Given I cache the countries count
		And   I am on the new country page
		When  I press "Create"
		Then  I should see "Name can't be blank"
		And   a new country has not been created
	
	Scenario: Failing Country Creation (name taken)
		Given a country named "Italy" exists
		And   I cache the countries count
		When  I go to the new country page
		And   I fill in "name" with "Italy"
		And   I press "Create"
		Then  I should see "Name has already been taken"
		And   a new country has not been created
		
	Scenario: Destroying Country
		Given a country named "Italy" exists
		And   I am on the countries page
		And   I should see "Italy"
		When  I follow "destroy"
		Then  I should see "Country was successfully destroyed"
		And   I should be on the countries page
		And   I should not see "Italy"
	
	Scenario: Failed Country Destroy
		Given a country named "Italy" belongs to a manufacturer
		And   I am on the countries page
		And   I should see "Italy"
		When  I follow "destroy"
		Then  I should see "Can't destroy:"
		And   I should be on the countries page
		And   I should see "Italy"
		