Given /^I am logged in as user$/ do
  email = 'admin@test.com'
  password = 'secret'
  Given "a user exist with email \"#{email}\" and password \"#{password}\""
  visit new_user_session_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "log in"
end

Given /^I am logged out$/ do
  visit logout_path
end

Then /^a new user with email "([^\"]*)" should (.*)exist$/ do |email, status|
  expectation = status.empty? ? :should_not : :should 
  User.find_by_email(email).send(expectation, be_nil)
end

Given /^a user exist with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  User.create!(
    :email => email,
    :password => password,
    :password_confirmation => password
  )
end
