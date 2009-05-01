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

class Post < ActiveRecord::Base
  
  belongs_to :user
  
  acts_as_geom :pos
  acts_as_taggable
  
  validates_presence_of :title, :body, :pos
  
  
  before_validation do |post|
    post.title = Sanitize.clean(post.title)
    post.body = Sanitize.clean(post.body, Sanitize::Config::RELAXED)
  end
    
end

