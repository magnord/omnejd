require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Area (0 0,0 5,5 5,5 0,0 0)" do
  before(:each) do
    @area = Area.make(:geom => Polygon.from_coordinates([[[0,0],[0,5],[5,5],[5,0],[0,0]]]))
    @id = @area.id
  end

  it "should create a new instance given valid attributes" do
    Area.find(@id).should == @area
  end

  it "should find the area in a bbox (-1 -1,6 6)" do
    Area.find_by_geom([[-1,-1],[6,6]]).should_not == nil
  end

  context "and posts on (1 1) and (7 7)" do
    before(:each) do
      @post_in = Post.make(:pos => Point.from_x_y(1,1))
      @post_out = Post.make(:pos => Point.from_x_y(7,7))
    end

    it "should contain (1 1)" do
      posts = @area.find_contained_posts 
      posts.should_not be nil
      posts.length.should == 1
      posts.first.title.should == @post_in.title
    end

    it "should not contain (7 7)" do
      posts = @area.find_contained_posts 
      posts.should_not include @post_out
    end
  end
end


# == Schema Information
# Schema version: 20090501121320
#
# Table name: areas
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#  geom       :geometry        not null, polygon, -1
#

