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
    area = Bas99.find_by_basnamn("Kronoberg")
    Area.find_by_name(:first, "Testarea") || Area.create(:name => area.basnamn, :geom => area.geom)
  end
  
  # Copy areas from sample DB bas99 to areas
  def self.load_bas99
    areas = Bas99.find(:all)
    areas.each do |area| 
      Area.create(:name => area.basnamn, :geom => area.geom ) 
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
  
  def self.find_areas_bbox(min_x, min_y, max_x, max_y)
    #Area.find_by_sql(["SELECT * FROM areas WHERE ST_Contains(areas.geom, ?)", point.as_wkt])
  end
end

