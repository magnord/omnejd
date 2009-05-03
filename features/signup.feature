Feature: Signup

Scenario: Register a new user

  When I am on the homepage
  And I follow "Register"
  And I fill all registration fields correctly
	And I press "Register"
	Then I should see "Account registered"
  
