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

class Area < ActiveRecord::Base
  
  auto_sanitizes :all
  
  has_many :watched_areas, :dependent => :destroy
  
  acts_as_geom :geom

  # Find all areas containing a point
  def self.find_containing_areas(point)
    Area.find_by_sql(["SELECT * FROM areas WHERE ST_Contains(areas.geom, ?)", point.as_wkt])
  end

  # Find all posts contained within this area
  def find_contained_posts
    Post.find_by_sql(["SELECT * FROM posts WHERE ST_Contains(?, posts.pos)", geom.as_hex_ewkb])
  end
  
  # Define a test area from sample data
  def self.test_area
    Area.find_by_name("Kronoberg")
  end
  
  # Copy areas from sample DB bas99 to areas
  def self.load_bas99
    areas = Bas99.find(:all)
    areas.each do |area| 
      Area.create(:name => area.basnamn, :geom => area.geom ) 
    end
  end
  
  # Copy areas from sample DB bas99 to areas
  def self.load_samswgs84
    areas = Samswgs84.find(:all)
    areas.each do |area| 
      Area.create(:name => area.samsnamn, :geom => area.geom[0] ) # First polygon from multipolygon
    end
  end


  
end

