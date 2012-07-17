Window = ->

	# Requirements
	Model = require "/lib/Model"
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

	self

module.exports = Window