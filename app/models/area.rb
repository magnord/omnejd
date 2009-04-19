class Area < ActiveRecord::Base
  acts_as_geom :geom
  
  # Find all areas containing a point
  def self.find_containing_areas(point)
    Area.find_by_sql(["SELECT * FROM areas WHERE ST_Contains(areas.geom, ?)", point.as_wkt])
  end
  
  # Find all posts contained within this area
  def find_contained_posts
    Post.find_by_sql(["SELECT * FROM posts WHERE ST_Contains(?, posts.pos)", geom.as_hex_ewkb])
  end
end
