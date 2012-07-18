(function() {

  exports.makeCall = function(phone) {
    var phoneSchema;
    phoneSchema = "tel:" + phone;
    if (Ti.Platform.canOpenURL(phoneSchema)) {
      return Ti.Platform.openURL(phoneSchema);
    }
  };

  exports.makeRoute = function(latitude, longitude) {
    Ti.Geolocation.purpose = " ";
    Ti.Geolocation.distanceFilter = 100;
    Ti.Geolocation.accuracy = Ti.Geolocation.ACCURACY_HUNDRED_METERS;
    return Ti.Geolocation.getCurrentPosition(function(e) {
      var routeSchema;
      if (!e.error) {
        routeSchema = "http://maps.google.com/maps?z=0.005&saddr=" + latitude + "," + longitude + "&daddr=" + e.coords.latitude + "," + e.coords.longitude;
        if (Ti.Platform.canOpenURL(routeSchema)) {
          return Ti.Platform.openURL(routeSchema);
        }
      }
    });
  };

}).call(this);
