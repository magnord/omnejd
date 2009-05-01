require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.make
    @id = @user.id
  end

  it "should create a new instance given valid attributes" do
    User.find(@id).should == @user
  end
  
  context "with a watched area" do
     before(:each) do
       @area = Area.make
       @watched_area = WatchedArea.make(:area => @area)
       @user.watched_areas << @watched_area
     end
     
     it "find the watched area" do
       @user.watched_areas.first.should == @watched_area
       @user.areas.first.should == @area
     end
   end
end
