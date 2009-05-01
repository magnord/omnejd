function create_draggable_marker()
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

function create_draggable_marker_for_edit(lat, lng) {
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

function updateLatlngText(lat, lng){
	$('#lat').val(lat);
	$('#lng').val(lng);
}

