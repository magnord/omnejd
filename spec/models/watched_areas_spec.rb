require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WatchedArea do
  before(:each) do
    @watched = WatchedArea.make
    @id = @watched.id
  end

  it "should create a new instance given valid attributes" do
    WatchedArea.find(@id).should == @watched
  end
end
