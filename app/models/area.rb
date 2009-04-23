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

class Area < ActiveRecord::Base
  acts_as_geom :geom

  # Watching users
  has_and_belongs_to_many :users

  # Define a test area from sample data
  def self.test_area
    area = Area.find_by_name("Testarea")
    if area.nil? then
     return Area.create(:name => "Testarea", :geom => Sweden5.find(20).geom.first) unless Area.find_by_name("Testarea")
    else
      return area
    end
  end

  # Find all areas containing a point
  def self.find_containing_areas(point)
    Area.find_by_sql(["SELECT * FROM areas WHERE ST_Contains(areas.geom, ?)", point.as_wkt])
  end

  # Find all posts contained within this area
  def find_contained_posts
    Post.find_by_sql(["SELECT * FROM posts WHERE ST_Contains(?, posts.pos)", geom.as_hex_ewkb])
  end
end

