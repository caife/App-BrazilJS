View = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object and get config informations
	model = new Model()
	config = model.getConfig().location

	# Create the View
	self = new ui.createView
		backgroundColor: "#FFFFFF"

	# Create the Annotation
	annotation = new ui.createMapAnnotation
		latitude: config.latitude
		longitude: config.longitude
		title: config.name
		subtitle: config.address

	# Create the MapView
	mapView = new ui.createMapView
		annotations: [annotation]
		region:
			latitude: config.latitude
			longitude: config.longitude
			latitudeDelta: 0.005
			longitudeDelta: 0.005

	self.add mapView

	self

module.exports = View