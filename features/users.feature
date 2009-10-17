Feature: Manage Users
	In order to allow other people to manage the website
	As a registered and logged in user
	I want to be able to register and create users
	
	Background:
		Given I am logged in as user
	
	Scenario: User Creation Page
		When I go to the new user page
		Then I should see "New User"
		And  I should see "Email"
		And  I should see "Password"
		And  I should see "Password confirmation"
		
	Scenario: Successful User Creation
		Given I go to the new user page
		And   I fill in "Email" with "andrea@email.com"
		And   I fill in "Password" with "secret"
		And   I fill in "Password confirmation" with "secret"
		When  I press "create"
		Then  I should see "User successfully created"
		And   a new user with email "andrea@email.com" should exist
		
	Scenario: Failing User Creation (no password)
		Given I go to the new user page
		And   I fill in "Email" with "andrea@email.com"
		And   I press "create"
		Then  I should see "Password is too short"
		And   I should see "Password doesn't match confirmation"
		And   a new user with email "andrea@email.com" should not exist
		
	Scenario: Failing User Creation (no email)
		Given  I go to the new user page
		And    I fill in "Password" with "secret"
		And    I fill in "Password Confirmation" with "secret"
		When   I press "create"
		Then   I should see "Email is too short"
		
	Scenario: Failing User Creation (password doesn't match confirmation)
		Given  I go to the new user page
		And    I fill in "Email" with "andrea@test.com"
		And    I fill in "Password" with "secret"
		And    I fill in "Password confirmation" with "password"
		When   I press "create"
		Then   I should see "Password doesn't match confirmation"
		And    a new user with email "andrea@test.com" should not exist