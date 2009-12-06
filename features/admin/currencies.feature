Feature: Manage Currencies
	In order to manage prices with different currencies
	As a logged in user
	I want to manage currencies
	
	Background:
		Given I am logged in as user
		
	Scenario: Currencies List Page is not accessible when logged out
		Given I am logged out
		When  I go to the currencies page
		Then  I should see "You must be logged in to access this page"
	
	Scenario: Listing Currencies
		When  I go to the currencies page
		Then  I should see "Listing Currencies"
		And   I should see "Name"

	Scenario: Creating New Currency
		Given I am on the currencies page
		And   I cache the currencies count
		And   I follow "new currency"
		When  I fill in "Name" with "EUR"
		And   I press "create"
		Then  I should see "Currency was successfully created"
		And   I should be on the currencies page
		And   a new currency has been created	
		
	Scenario: Failed New Currency Creation
		Given a currency named "EUR" exists
		And   I am on the new currency page
		And   I cache the currencies count
		When  I fill in "Name" with "EUR"
		And   I press "create"
		Then  I should see "Name has already been taken"
		And   a new currency has not been created
		
	Scenario: Destroying Currency
		Given a currency named "USD" exists
		When  I go to the currencies page
		And   I follow "destroy"
		Then  I should see "Currency was successfully destroyed"
		And   I should be on the currencies page
		And   I should not see "USD"
