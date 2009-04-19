class Post < ActiveRecord::Base
  belongs_to :user
  
  acts_as_geom :pos
end

# == Schema Information
# Schema version: 20090419181824
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#  pos        :geometry        not null, point, -1
#

