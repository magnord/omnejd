module OmnejdMap
  
  def add_post_marker(map, post)
    map.overlay_init(GMarker.new([post.pos.y, post.pos.x],
    :title => post.title,:info_window => post.body)) # TODO: Add maxWidth for info_window
  end
  
  # Outline the current watched area (first center and zoom the map to suit the extent of the area)
  def outline_area(map, area, draw = true)
    if area then
      polygon = area.geom
      envelope = polygon.envelope
      map.record_init(GPolygon.from_georuby(polygon,"#cc0000",2,0.8,"#aa2222",0.1).declare('areaOutline'))
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
  
  # Set map center and zoom level to show all user areas. If no user, use geolocation on IP
  def set_center_and_zoom_for_user_areas(map, user, user_areas)
    if user && !user_areas.empty? then
      area = user_areas.first
      polygon = area.geom
      envelope = polygon.envelope
      center = GLatLng.from_georuby(envelope.center)
      zoom = map.get_bounds_zoom_level(GLatLngBounds.from_georuby(envelope))
    else
      center = [58.9, 11.93]
      zoom = 8
    end
    map.clear_overlays
    map.center_zoom_init(center,zoom)
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