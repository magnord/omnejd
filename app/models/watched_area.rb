# == Schema Information
# Schema version: 20090501121320
#
# Table name: watched_areas
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  area_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#

class WatchedArea < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
end
