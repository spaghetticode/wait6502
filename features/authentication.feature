Feature: User Login/Logout
	In order to persist my session securely
	As a registered user
	I want to login and logout from the website
	
	Scenario: Login Link is present when not logged in
		When I am on the homepage
		Then I should see "login"
		
	Scenario: Login Link is missing when logged in
		Given I am logged in as user
		When  I am on the homepage
		Then  I should not see "login"

	Scenario: Login Page
		When I go to the user login page
		Then I should see "Email"
		And  I should see "Password"
		
	Scenario: Successful Login
		Given a user exist with email "andrea@test.it" and password "secret"
		And   I go to the user login page
		When  I fill in "Email" with "andrea@test.it"
		And   I fill in "Password" with "secret"
		And   I press "log in"
		Then  I should see "User successfully logged in"
	
	Scenario: Failed Login
		Given a user exist with email "andrea@test.it" and password "secret"
		And   I go to the user login page
		When  I fill in "Email" with "andrea@test.it"
		And   I fill in "Password" with "password"
		And   I press "log in"
		Then  I should see "Password is not valid"

		Scenario: Logout Link is present when logged in
			Given I am logged in as user
			When  I am on the homepage
			Then  I should see "logout"

		Scenario: Logout Link is missing when not logged in
			When I am on the homepage
			Then I should not see "logout"

		Scenario: Successful Log Out
			Given I am logged in as user
			And  	I am on the homepage
			When  I follow "logout"
			Then  I should be on the homepage