module OmnejdMap
  include ActionView::Helpers::PrototypeHelper
  include ActionView::Helpers::JavaScriptHelper
  
  def add_post_marker(map, post)
    map.overlay_init(GMarker.new([post.pos.y, post.pos.x],
    :title => post.title,:info_window => post.body)) # TODO: Add maxWidth for info_window
  end
  
  # Outline the current watched area (first center and zoom the map to suit the extent of the area)
  def outline_area(map, area, draw = true)
    if area then
      polygon = area.geom
      envelope = polygon.envelope
      map.record_init(GPolygon.from_georuby(polygon,"#cc0000",3,0.4,"#aa2222",0.1).declare('areaOutline'))
      center = GLatLng.from_georuby(envelope.center)
      zoom = map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))     
    else
      # No area defined, center on arbitrary location (should use goelocation on IP).
      center = [58.9, 11.93]
      zoom = 8
    end
    map.clear_overlays
    map.center_zoom_init(center,zoom)
    #add_polyline_tooltip('areaOutline', @area.name)
    map.record_init("map.addOverlay(areaOutline);") if draw
  end
  
  # Add map event to find alla shown areas when map changes
  def add_map_event_find_areas(map)
    func_str = "bounds = map.getBounds();"
    func_str += remote_function(:url => { :action => :find, :min_x => "minX_ph", :min_y => "minY_ph", 
                                           :max_x => "maxX_ph", :max_y => "maxY_ph"} )
    func_str[/minX_ph/] = "'+bounds.getSouthWest().lat()+'" # replace placeholders
    func_str[/minY_ph/] = "'+bounds.getSouthWest().lng()+'"
    func_str[/maxX_ph/] = "'+bounds.getNorthEast().lat()+'"
    func_str[/maxY_ph/] = "'+bounds.getNorthEast().lng()+'"
    map.event_init(map, :load, "function() { " + func_str + " }")
    # This move-end event causes a double event trigger (and a double exepnsive Area.find_by_geom()) 
    # with the above load event on the first page load. TODO: Make this a single event.
    map.event_init(map, :moveend, "function() { " + func_str + " }") 
  end
  
  # Set map center and zoom level to show all user areas. If no user, use geolocation on IP
  def set_center_and_zoom_for_user_areas(map, user_areas)
    if !user_areas.empty? then
      area = user_areas.first # TODO: take all user areas into consideration
      polygon = area.geom
      envelope = polygon.envelope
      center = GLatLng.from_georuby(envelope.center)
      zoom = map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope)).to_javascript
    else
      center = GLatLng.new([59.32, 18.07])
      zoom = 13
    end
    map.clear_overlays
    # We can't use YM4R's map.center_zoom_init(center,zoom) because it will insert setCenter before
    # our generated GMap2 load event listener setup (and that order doesn't work).
    map.record_init("map.setCenter(#{center.to_javascript},#{zoom});")
  end
  
  def add_polyline_tooltip(map, polyline, tooltip)
    map.record_init("add_polyline_tooltip(#{polyline},'#{tooltip}');")
  end
  
  # Create a new draggable marker to define the postion of a new post
  def create_draggable_marker(map)
    map.record_init('create_draggable_marker();')
  end

  # Create a draggable marker to edit the postion of a post
  def create_draggable_marker_for_edit(map, post)
    map.record_init("create_draggable_marker_for_edit(#{post.pos.x},#{post.pos.y});")
  end
end