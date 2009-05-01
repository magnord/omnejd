# == Schema Information
# Schema version: 20090501121320
#
# Table name: sweden5
#
#  id         :integer         not null, primary key
#  gid        :string(255)     not null
#  name       :string(255)
#  name_ascii :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  geom       :geometry        not null, multi_polygon, -1
#

class Sweden5 < ActiveRecord::Base
  set_table_name "sweden5"
end

