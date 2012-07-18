exports.makeCall = (phone) ->
	
	phoneSchema = "tel:#{phone}"

	if Ti.Platform.canOpenURL phoneSchema
		Ti.Platform.openURL phoneSchema


exports.makeRoute = (latitude, longitude) ->

	# Configure Geolocation
	Ti.Geolocation.purpose = " "
	Ti.Geolocation.distanceFilter = 100
	Ti.Geolocation.accuracy = Ti.Geolocation.ACCURACY_HUNDRED_METERS

	Ti.Geolocation.getCurrentPosition (e) ->

		if !e.error

			routeSchema = "http://maps.google.com/maps?z=0.005&saddr=#{latitude},#{longitude}&daddr=#{e.coords.latitude},#{e.coords.longitude}"

			if Ti.Platform.canOpenURL routeSchema
				Ti.Platform.openURL routeSchema