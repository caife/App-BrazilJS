Window = ->

	# Requirements
	Model = require "/lib/Model"
	Localization = require "/lib/Localization"
	ui = require "/ui/components"

	# Instance Model object and get config informations
	model = new Model()
	config = model.getConfig().localization

	# Create the Window
	self = new ui.createWindow
		title: L("localization")

	# Create the MapView
	mapView = new ui.createMapView
		region:
			latitude: config.latitude
			longitude: config.longitude
			latitudeDelta: 0.005
			longitudeDelta: 0.005

	# Create the Annotation
	annotation = new ui.createMapAnnotation
		latitude: config.latitude
		longitude: config.longitude
		title: config.name
		subtitle: config.address
		rightButton: Ti.UI.iPhone.SystemButton.CONTACT_ADD

	mapView.addAnnotation annotation

	self.add mapView

	# Events handler
	mapView.addEventListener "click", (e) ->

		if e.clicksource == "rightButton"

			mapOptions = Ti.UI.createOptionDialog
				title: L("title_map_options")
				destructive: 2
				options: [
					L("call")
					L("route")
					L("cancel")
				]

			mapOptions.show()

			mapOptions.addEventListener "click", (e) ->

				switch e.index
					when 0 then Localization.call config.phone
					when 1 then Localization.makeRoute config.latitude, config.longitude

	self

module.exports = Window