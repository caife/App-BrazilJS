Window = ->

	# Requirements
	Model = require "/lib/Model"
	Localization = require "/lib/Localization"
	ui = require "/ui/components"

	# Instance Model object and get config informations
	model = new Model()
	config = model.getConfig()
	localization = config.localization

	# Create the Window
	self = new ui.createWindow
		title: L("localization")

	# Create the Annotation
	annotation = new ui.createMapAnnotation
		latitude: localization.latitude
		longitude: localization.longitude
		title: localization.name
		subtitle: localization.address
		rightButton: Ti.UI.iPhone.SystemButton.CONTACT_ADD

	# Create the MapView
	mapView = new ui.createMapView
		annotations: [annotation]
		region:
			latitude: localization.latitude
			longitude: localization.longitude
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
					when 0 then Localization.contact config.mail_contact, config.theme.ios.barColor
					when 1 then Localization.makeRoute localization.latitude, localization.longitude

	self

module.exports = Window