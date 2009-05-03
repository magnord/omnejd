Feature: Posts

Scenario: Save a new post

	Given a watched area "Testarea"
  When I am on the posts page
  And I follow "New post"
  And I fill in "Title" with "Post title"
  And I fill in "Body" with "Body body body body."
	And I fill in "Tag list" with "tag1, tag2"
  And I position the post within "Testarea"
	And I press "Create"
	Then I should see "Post title"
	And I should see "Body"
	And I should see "tag1"	
	And I should see "tag2"
	