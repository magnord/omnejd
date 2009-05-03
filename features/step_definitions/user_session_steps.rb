Given /^an existing user "([^\"]*)"$/ do |login|
  User.make(:login => login)
end
