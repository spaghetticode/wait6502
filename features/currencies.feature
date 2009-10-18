Feature: Manage Currencies
	In order to manage prices with different currencies
	As a user
	I want to manage currencies
		
	Scenario: Currencies List Page is not accessible when logged out
		When I go to the currencies page
		Then I should see "You must be logged in to access this page"
	
	Scenario: Listing Currencies
		Given I am logged in as user
		When  I go to the currencies page
		Then  I should see "Listing Currencies"
		And   I should see "Symbol"
		And   I should see "Code"

	Scenario: Creating New Currency
		Given I am logged in as user
		And   I am on the currencies page
		And   I follow "new currency"
		When  I fill in "Code" with "Euro"
		And   I fill in "symbol" with "EURO"
		And   I press "create"
		Then  I should see "Currency was successfully created"
		And   I should be on the currencies page
	
	Scenario: Updating Currency
		Given I am logged in as user
		And   currency with code "EURO" and symbol "€" exists
		When  I go to the currencies page
		And   I follow "edit"
		And   I fill in "symbol" with "&euro;"
		And   I press "update"
		Then  I should see "Currency was successfully updated"
		And   I should be on the currencies page
		And   I should see "&euro;"
		
	Scenario: Destroying Currency
		Given I am logged in as user
		And   currency with code "USD" and symbol "$" exists
		When  I go to the currencies page
		And   I follow "destroy"
		Then  I should see "Currency was successfully destroyed"
		And   I should be on the currencies page
		And   I should not see "USD"
