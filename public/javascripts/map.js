//
// Marker code
//

// Add a map marker with mouse and click events
function addMarker(id, x, y) {
	markers[id] = new GMarker(new GLatLng(y, x));
	var cssId = '#post' + id;
	// Show info window in map pane and highlight post on mouseover
	GEvent.addListener(markers[id], 'mouseover', function(pos) {
		$(cssId).toggleClass('highlight');
		if (pos.lat() > map.getCenter().lat()) {
			// marker is in the top half of map, show info in bottom half
			$("#post-info" + id).addClass("info-bottom").removeClass("info-top");
		} else {
			// marker is in the bottom half of map, show info in top half
			$("#post-info" + id).addClass("info-top").removeClass("info-bottom");
		}
		$("#post-info" + id).appendTo("#map_div").fadeIn(); //TODO: Will this append the same div repeatedly?
	});
	// Remove info window and post highlight
	GEvent.addListener(markers[id], 'mouseout', function(_pos) {
		$("#post-info" + id).hide();
		$(cssId).toggleClass('highlight');
	});
	// Show post when marker is clicked
	GEvent.addListener(markers[id], 'click', function(_pos) {
		window.location.replace('/posts/'+ id);
	});
	map.addOverlay(markers[id]);
}

// Draggable marker for positioning new posts
function createDraggableMarker()
{
	// intialize the values in form fields to 0
	updateLatlngText(0, 0);
	var currMarker;
	// if the user clicks on map with a marker, remove old marker and add new
	GEvent.addListener(map, "click", function(marker, point) {
		// remove the previous marker if it exists
		if (currMarker) {
			map.removeOverlay(currMarker);
		}
		currMarker = new GMarker(point, {draggable: true});
		map.addOverlay(currMarker);
		// update the form fields
		updateLatlngText(point.y, point.x);
	});
	// Similarly drag event is used to update the form fields
	GEvent.addListener(currMarker, "drag", function() {
		updateLatlngText(currMarker.getPoint().lat(), currMarker.getPoint().lng());
	});
}

// Draggable marker for editing position of posts
function createDraggableMarkerForEdit(lat, lng) {
	// initalize form fields
	updateLatlngText(lat, lng);
	// initalize marker
	var currMarker = new GMarker( new GLatLng(lat, lng), {draggable: true} );
	map.addOverlay(currMarker);
	// Handle drag events to update the form text fields
	GEvent.addListener(currMarker, 'drag', function() {
		updateLatlngText(currMarker.getPoint().lat(), currMarker.getPoint().lng());
	});
}

// Update hidden form fields
function updateLatlngText(lat, lng){
	$('#lat').val(lat);
	$('#lng').val(lng);
}

//
// Area code
//

// Draw a watched area in the area selection map
function drawWatchedArea(points, userId, areaId, watchedId, name) {
	// Add polygon
  poly = new GPolygon(points, '#333333', 2, 0.8, '#aa3333', 0.5);
  poly.watchedId = watchedId;
  poly.name = name;
  poly.userId = userId;
  poly.areaId = areaId;
  map.addOverlay(poly);
  addWatchedAreaEvents(poly);
  return poly;
}

function addWatchedAreaEvents(poly) {
  // Write area name at mousover
  GEvent.clearInstanceListeners(poly);
  GEvent.addListener(poly, 'mouseover', function() { 
    $('#area_name').text(this.name);
  });

  // Delete watched area at click
  GEvent.addListener(poly, 'click', function() { 
	  currentPoly = this;
    $.ajax({
      url: '/users/'+this.userId+'/watched_areas/'+this.watchedId+'.js',
      type: 'post',
      dataType: 'script',
      data: { '_method': 'delete' },
      success: function() { 
        }
      });
    });
}

// Draw an unwatched area in the area selection map
function drawArea(points, userId, areaId, name) {
  // Add polygon
  poly = new GPolygon(points, '#333333', 2, 0.5, '#aa3333', 0.0);
  poly.watchedId = 0;
  poly.name = name;
  poly.userId = userId;
  poly.areaId = areaId;
  map.addOverlay(poly);
	addAreaEvents(poly);
	return poly;
}

function addAreaEvents(poly) {
 // Highlight area at mousover
  GEvent.clearInstanceListeners(poly);
  GEvent.addListener(poly, 'mouseover', function() { 
    this.opacity = 0.5; this.redraw(true);  
    $('#area_name').val(this.name);
  });

  // Remove highlight at mouseout
  GEvent.addListener(poly, 'mouseout', function() { 
    this.opacity = 0.0; this.redraw(true); 
  });

  // Add unwatched area to watched at click
  GEvent.addListener(poly, 'click', function() { 
	  currentPoly = this;
    $.post('/users/'+this.userId+'/watched_areas.js', 
      { area_id: this.areaId }, null, 'script');
  });
}
