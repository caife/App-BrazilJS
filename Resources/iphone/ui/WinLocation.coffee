Window = ->

	# Requirements
	Model = require "/lib/Model"
	Location = require "/lib/Location"
	ui = require "/ui/components"

	# Instance Model object and get config informations
	model = new Model()
	config = model.getConfig()
	location = config.location

	# Create the Window
	self = new ui.createWindow
		title: L("location")

	# Create the Annotation
	annotation = new ui.createMapAnnotation
		latitude: location.latitude
		longitude: location.longitude
		title: location.name
		subtitle: location.address
		rightButton: Ti.UI.iPhone.SystemButton.CONTACT_ADD

	# Create the MapView
	mapView = new ui.createMapView
		annotations: [annotation]
		region:
			latitude: location.latitude
			longitude: location.longitude
			latitudeDelta: 0.005
			longitudeDelta: 0.005

	self.add mapView

	# Events handler
	mapView.addEventListener "click", (e) ->

		if e.clicksource == "rightButton"

			mapOptions = Ti.UI.createOptionDialog
				title: L("title_map_options")
				destructive: 2
				options: [
					L("contact")
					L("route")
					L("cancel")
				]

			mapOptions.show()

			mapOptions.addEventListener "click", (e) ->

				switch e.index
					when 0 then Location.contact config.mail_contact, config.theme.ios.barColor
					when 1 then Location.makeRoute location.latitude, location.longitude

	self

module.exports = Window