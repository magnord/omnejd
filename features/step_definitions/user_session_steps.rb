Given /^an existing user "([^\"]*)"$/ do |login|
  User.make(:login => login)
end

Given /^a logged in user "([^\"]*)"$/ do |login|
  @user = User.make(:login => login)
  visit '/'
  click_link "Log in"
  fill_in "Login", :with => login
  fill_in "Password", :with => "password"
  click_button "Login"  
end

