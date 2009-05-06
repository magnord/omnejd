// Global variables t
// The polygon currently acted upon
var currentPoly;
// The current set of posts
var currentPosts = {};
// Map markers
var markers = {};

// Set format on all ajax requests (not sure this works as it should).
jQuery.ajaxSetup({  
	'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

// Always send the authenticity_token with ajax (from http://www.viget.com/extend/ie-jquery-rails-and-http-oh-my)
$(document).ajaxSend(function(event, request, settings) {
	if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
	// settings.data is a serialized string like "foo=bar&baz=boink" (or null)
	settings.data = settings.data || "";
	settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

// Extend array with a 'contains element' method
Array.prototype.contains = function (element) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == element) {
			return true;
		}
	}
	return false;
}
