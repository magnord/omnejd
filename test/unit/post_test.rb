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
      @post.title.should == @title
    end

    should "find the author of the post" do
      author = @post.user
      author.should_not be(nil)
      author.login.should == @user.login
    end
  end
end