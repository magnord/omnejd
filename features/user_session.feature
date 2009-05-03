Feature: User Session

Scenario: Login a registered user

	Given an existing user "pelle
  When I am on the homepage
  And I follow "Log In"
  And I fill in "Login" with "pelle"
  And I fill in "Password" with "password"
	And I press "Login"
	Then I should see "Login successful"
  
