Feature: Posts

Scenario: Save posts within and without a watched area

	Given a logged in user "pelle"
	And a watched area "Testarea"
	When I am on the posts page
	And I follow "New post"
	And I fill in "Title" with "Relevant event"
	And I fill in "Body" with "Body body body body."
	And I fill in "Tag list" with "tag1, tag2"
	And I position the post within "Testarea"
	And I press "Create"
	Then I should see "Relevant event"
	And I should see "Body"
	And I should see "tag1"	
	And I should see "tag2"
	
	When I am on the posts page
	And I follow "New post"
	And I fill in "Title" with "Irrelevant event"
	And I fill in "Body" with "Body body body body."
	And I position the post outside "Testarea"
	And I press "Create"
	And I follow "Back to all posts"
	Then I should not see "Irrelevant event"
	