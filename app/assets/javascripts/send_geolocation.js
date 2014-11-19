function startNavigator() {
  if(navigator.geolocation) {
    setInterval(function() {
      navigator.geolocation.getCurrentPosition(sendPosition);
    }, 10000);

  }
}

function sendPosition(position){
    data = { latitude: position.coords.latitude, longitude: position.coords.longitude};
    // console.log(data)
    $.ajax({
        url: '/geolocation', method: 'PUT', data: {geolocation: data}
      }).fail(function(err) {
        console.log( "Error: " + err );
      });
  };
