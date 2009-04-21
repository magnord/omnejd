require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @post = Post.make
    @id = @post.id
  end

  it "should create a new instance given valid attributes" do
    @post = Post.find(@id)
  end
end
