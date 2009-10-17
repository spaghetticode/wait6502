Given /^I am logged in as user$/ do
  email = 'admin@test.com'
  password = 'secret'
  User.create!(
    :email => email,
    :password => password,
    :password_confirmation => password
  )
  visit new_user_session_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "log in"
end

Then /^a new user with email "([^\"]*)" should exist$/ do |email|
  User.find_by_email(email).should_not be_nil
end

Then /^a new user with email "([^\"]*)" should not exist$/ do |email|
  User.find_by_email(email).should be_nil
end
