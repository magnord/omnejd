require "test_helper"

class AreaTest < ActiveSupport::TestCase 
  context "An Area instance with bbox (0 0,5 5)" do
    setup do
      @area = Factory(:area, :geom => Polygon.from_points([[
        Point.from_x_y(0,0),
        Point.from_x_y(0,5),
        Point.from_x_y(5,5),
        Point.from_x_y(5,0),
        Point.from_x_y(0,0)]]))
      @area_name = @area.name
    end

    should "find the area" do
      area = Area.find_by_name(@area_name)
      assert_not_nil area
      assert_equal area.name, @area_name
    end

    should "find the area in a bbox (-1 -1,6 6)" do
      assert_not_nil Area.find_by_geom([[-1,-1],[6,6]])
    end

    context "and posts on (1 1) and (7 7)" do
      setup do
        @post_in = Factory(:post, :pos => Point.from_x_y(1,1))
        @post_out = Factory(:post, :pos => Point.from_x_y(7,7))
      end

      should "post_in be inside the area, post_out should not" do
        posts = @area.find_contained_posts 
        assert_not_nil posts
        assert posts.length > 0
        posts.first.title = @post_in.title
        assert_does_not_contain posts, @post_out
      end
    end
  end

end
