# == Schema Information
# Schema version: 20090501121320
#
# Table name: bas99
#
#  id         :integer         not null, primary key
#  basnamn    :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  geom       :geometry        not null, polygon, -1
#

class Bas99 < ActiveRecord::Base
  
  set_table_name "bas99"
  
  auto_sanitizes :all
  
end
