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
  
  def self.new_from_latlng_params_and_user(params, new_user)
    Post.new(:title => params[:post][:title], :body => params[:post][:body], :user => new_user,
      :pos => Point.from_x_y(params[:lng], params[:lat]))
  end
  
end

