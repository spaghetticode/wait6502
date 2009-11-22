@focus
In order to manage original prices added by visitors
As a logged user
I want to approve or destroy tainted original prices
	
	Background:
		Given I am logged in as user
	
	Scenario: List Tainted Original Prices
		Given the following original prices exist:
		| hardware  | country| currency| year| amount| tainted|
		| Amiga 1000| USA    | USD     | 1985| 3000  | true   |
		| Amiga 2000| Italy  | EUR     | 1987| 2000  | nil    |
		
		When I go to the tainted original prices page
		Then I should see "Amiga 1000"
		And  I should see "1985"
		But  I should not see "Amiga 2000"
	
	Scenario: Destroy Tainted Original Price
		Given the following original price exist:
		| hardware  | country| currency| year| amount| tainted|
		| Amiga 1000| USA    | USD     | 1985| 3000  | true   |
		And  I am on the tainted original prices page
		When I follow "Destroy"
		Then I should see "Original Price was successfully destroyed"
		And  I should be on the tainted original prices page
		And  I should not see "Amiga 1000"
		And  I should not see "1985"
		
	Scenario: Approve Tainted Original Price
		Given the following original price exist:
		| hardware  | country| currency| year| amount| tainted|
		| Amiga 1000| USA    | USD     | 1985| 3000  | true   |
		And  I am on the tainted original prices page
		When I press "Approve"
		Then I should see "Original price was successfully approved"
		And  I should be on the tainted original prices page
		And  I should not see "Amiga 1000"
		And  the original price is now approved
		
	Scenario: Edit Tainted Original Price
		Given the following original price exist:
		| hardware  | country| currency| year| amount| tainted|
		| Amiga 1000| USA    | USD     | 1985| 3000  | true   |
		And  I am on the tainted original prices page
		When I follow "edit"
		And  I fill in "amount" with "1000"
		And  I press "Edit"
		Then I should see "Original Price was successfully updated."
		And  I should be on the tainted original prices page
		And  I should see "1000"
		But  I should not see "3000"
		