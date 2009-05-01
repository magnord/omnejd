// Global variable to hold the polygon currently acted upon
var currentPoly;

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
