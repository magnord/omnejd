require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context "A Post instance" do
    setup do 
      post = Factory(:post)
      @title = post.title
      @post = Post.find_by_title(@title)
      @user = @post.user
    end
    
    should_belong_to :user

    should "find the post" do
      @post = Post.find_by_title(@title)
      assert_equal @post.title, @title
    end

    should "find the author of the post" do
      author = @post.user
      assert_not_nil author
      assert_equal author.login, @user.login # This is not a particularly good test...
    end
  end
end