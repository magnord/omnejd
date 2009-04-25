function create_draggable_marker()
{
	// intialize the values in form fields to 0
	document.getElementById("lng").value = 0;
	document.getElementById("lat").value = 0;
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
		document.getElementById("lng").value = point.x;
		document.getElementById("lat").value = point.y;
	});
	// Similarly drag event is used to update the form fields
	GEvent.addListener(currMarker, "drag", function() {
		document.getElementById("lng").value = currMarker.getPoint().lng();
		document.getElementById("lat").value = currMarker.getPoint().lat();
	});
}

function create_draggable_marker_for_edit(lng, lat) {
	// initalize form fields
	document.getElementById('lng').value = lng;
	document.getElementById('lat').value = lat;
	// initalize marker
	var currMarker = new GMarker( new GLatLng(lat, lng), {draggable: true} );
	map.addOverlay(currMarker);
	// Handle drag events to update the form text fields
	GEvent.addListener(currMarker, 'drag', function() {
		document.getElementById('lng').value = currMarker.getPoint().lng();
		document.getElementById('lat').value = currMarker.getPoint().lat();
	});
}

// Attach mouseover event to a polyline that will trigger the tooltip
function add_polyline_tooltip(polyline, tooltip) {
	GEvent.addListener(polyline, 'mouseover', function() {
		this.overlay = new MapTooltip(this, tooltip);
		map.addOverlay(this.overlay);
		// Attach mousout event to the polyline that will delete the tooltip
		GEvent.addListener(polyline, 'mouseout', function() {
			map.removeOverlay(this.overlay);
		});
	});
}
