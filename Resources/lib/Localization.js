(function() {

  exports.call = function(phone) {
    var phoneSchema;
    phoneSchema = "tel:" + phone;
    if (Titanium.Platform.canOpenURL(phoneSchema)) {
      return Titanium.Platform.openURL(phoneSchema);
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
        if (Titanium.Platform.canOpenURL(routeSchema)) {
          return Titanium.Platform.openURL(routeSchema);
        }
      }
    });
  };

}).call(this);
