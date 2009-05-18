module OmnejdMap
  include ActionView::Helpers::JavaScriptHelper
  
  def init_map
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true, :map_type => true)
  end
  
  def add_post_marker(map, post)
    map.overlay_init(GMarker.new([post.pos.y, post.pos.x],
    :title => post.title,:info_window => post.body)) # TODO: Add maxWidth for info_window
  end
  
  # Outline the a set of areas (first center and zoom the map to suit the extent of all the areas)
  def outline_areas(map, areas, draw = true)
    if !areas.blank? then
      set_center_and_zoom_for_areas(map, areas)
      for area in areas do
        map.record_init(GPolygon.from_georuby(area.geom,"#333333", 1, 0.5, "#ff3333", 0.1).declare('areaOutline')) if draw
        map.record_init("map.addOverlay(areaOutline);") if draw
      end  
    end
  end
  
  # Set map center and zoom level to show all areas. If no areas, use geolocation on IP
  def set_center_and_zoom_for_areas(map, areas)
    if !areas.blank? then
      multi_polygon = MultiPolygon.from_polygons(areas.map {|a| a.geom})
      envelope = multi_polygon.envelope
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
  
  def set_center_and_zoom_for_post(map, post)
    center = GLatLng.from_georuby(post.pos)
    zoom = 15      
    map.clear_overlays
    # We can't use YM4R's map.center_zoom_init(center,zoom) because it will insert setCenter before
    # our generated GMap2 load event listener setup (and that order doesn't work).
    map.record_init("map.setCenter(#{center.to_javascript},#{zoom});")
  end
  
  
  # Add map event to find all shown areas when map changes
  def add_map_event_find_areas(map)
    func_str = "bounds = map.getBounds();"
    func_str += "$.get('#{find_areas_path}', { 
      min_x: bounds.getSouthWest().lat(),
      min_y: bounds.getSouthWest().lng(),
      max_x: bounds.getNorthEast().lat(),
      max_y: bounds.getNorthEast().lng()
    }, null, 'script');"
    map.event_init(map, :moveend, "function() { " + func_str + " }") 
  end
  
  # Add map event to find all shown posts when map changes
   def add_map_event_find_posts(map)
     func_str = "bounds = map.getBounds();"
     func_str += "$.get('#{find_posts_path}', { 
       min_x: bounds.getSouthWest().lat(),
       min_y: bounds.getSouthWest().lng(),
       max_x: bounds.getNorthEast().lat(),
       max_y: bounds.getNorthEast().lng()
     }, null, 'script');"
     map.event_init(map, :moveend, "function() { " + func_str + " }") 
     map.record_init("GEvent.trigger(map, 'moveend');")
   end
  
  # Create a new draggable marker to define the postion of a new post
  def create_draggable_marker(map)
    map.record_init('create_draggable_marker();')
  end

  # Create a draggable marker to edit the postion of a post
  def create_draggable_marker_for_edit(map, post)
    map.record_init("create_draggable_marker_for_edit(#{post.pos.y},#{post.pos.x});")
  end
  
  # Generate string of GLatGng constructors for use in GPolygon
  def genGLatLngs(area)
    area.geom.rings[0].points.map { |p| "new GLatLng(#{p.y},#{p.x})" }.join(',')
  end
end