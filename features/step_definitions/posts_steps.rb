Given /^a watched area "([^\"]*)"$/ do |area_name|
  Area.make(:name => area_name)
end

When /^I position the post within "([^\"]*)"$/ do |area_name|
  area = Area.find_by_name(area_name)
  center = area.geom.envelope.center
  set_hidden_field 'lat', :to => center.y
  set_hidden_field 'lng', :to => center.x  
end
