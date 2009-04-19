require "test_helper"

class AreaTest < ActiveSupport::TestCase 
  context "An Area instance" do
    setup do
      @area = Factory(:area)
      @area_name = Factory.attributes_for(:area)[:name] # In case creation fails
    end

    should "find the area" do
      area = Area.find_by_name(@area_name)
      assert_not_nil area
      assert_equal area.name, @area_name
    end

    should "find the area in a bounding box" do
      assert_not_nil Area.find_by_geom([[-1,-1],[6,6]])
    end

    context "and posts" do
      setup do
        @post_in = Factory(:post_in)
        @post_out = Factory(:post_out)
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