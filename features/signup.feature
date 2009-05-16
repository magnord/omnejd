Feature: Signup

Scenario: Register a new user

	When I am on the homepage
	And I follow "Register"
	And I fill all registration fields correctly
	And I press "Register"
	Then I should see "Account registered"

Scenario: Try to register a new user but typo in password

	When I am on the homepage
	And I follow "Register"
	And I fill all registration fields correctly
	And I fill in "Password confirmation" with "typo"
	And I press "Register"
	Then I should see "Password doesn't match confirmation"

