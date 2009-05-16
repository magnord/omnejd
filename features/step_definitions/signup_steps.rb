When /^I fill all registration fields correctly$/ do
  fill_in "Login", :with => "good"
  fill_in "Email", :with => "good@example.com"
  fill_in "Password", :with => "password"
  fill_in "Password confirmation", :with => "password"
end
