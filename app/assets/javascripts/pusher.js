Pusher.log = function(message) {
  if (window.console && window.console.log) {
    window.console.log(message);
  }
};

var pusher = new Pusher('1b45c5377dfe72b3c0ad');



function updateUserLocation(data) {
  if(typeof marker !== "undefined") {
    handler.removeMarker(marker);
  }
  marker = handler.addMarker({lat: data.latitude,lng: data.longitude})
  $('#last_updated_geolocation').text(data.update_at)
}
