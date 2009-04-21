require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.make
    @id = @user.id
  end

  it "should create a new instance given valid attributes" do
    User.find(@id).should == @user
  end
end
