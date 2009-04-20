require "test_helper"

class AreaTest < ActiveSupport::TestCase 
  context "An Area instance with bbox (0 0,5 5)" do
    setup do
      @area = Factory(:area, :geom => Polygon.from_coordinates([[[0,0],[0,5],[5,5],[5,0],[0,0]]]))
      @area_name = @area.name
    end

    should "find the area" do
      area = Area.find_by_name(@area_name)
      area.should_not be nil
      area.name.should == @area_name
    end

    should "find the area in a bbox (-1 -1,6 6)" do
      Area.find_by_geom([[-1,-1],[6,6]]).should_not be nil
    end

    context "and posts on (1 1) and (7 7)" do
      setup do
        @post_in = Factory(:post, :pos => Point.from_x_y(1,1))
        @post_out = Factory(:post, :pos => Point.from_x_y(7,7))
      end

      should "post_in be inside the area, post_out should not" do
        posts = @area.find_contained_posts 
        posts.should_not be nil
        posts.length.should > 0
        posts.first.title.should == @post_in.title
        posts.should exclude @post_out
      end
    end
  end

end

# == Schema Information
# Schema version: 20090419181824
#
# Table name: areas
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#  geom       :geometry        not null, polygon, -1
#

