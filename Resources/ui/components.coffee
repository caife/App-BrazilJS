Model = require "/lib/Model"
model = new Model()
config = model.getConfig()

# Defaults
isAndroid = if (Ti.Platform.osname == "android") then true else false
gradientColor = config.theme.barColor


# Window
exports.createWindow = (dict) ->

	defaults = 
		barColor: gradientColor

	window = Ti.UI.createWindow applyConfig dict, defaults

	window


# View
exports.createView = (dict) ->

	defaults = 
		top: if isAndroid then 94 else 0

	view = Ti.UI.createView applyConfig dict, defaults

	view


# MapView
exports.createMapView = (dict) ->

	defaults =
		top: 0

	mapView = Ti.Map.createView applyConfig dict, defaults

	mapView

# MapAnnotation
exports.createMapAnnotation = (dict) ->

	defaults = 
		draggable: false
		animate: true
		pincolor: Ti.Map.ANNOTATION_RED

	annotation = Ti.Map.createAnnotation applyConfig dict, defaults

	annotation


# TableView
exports.createTableView = (dict) ->

	defaults = 
		top: 0

	tableView = Ti.UI.createTableView applyConfig dict, defaults

	tableView


# TableViewRows
exports.createSpeakerRow = (dict) ->

	self = Ti.UI.createTableViewRow
		speaker_obj: dict
		hasChild: if isAndroid then false else true
		height: Ti.UI.SIZE


	image = Ti.UI.createImageView
		image: "/images/speakers/#{dict.picture}"
		left: "5dp"
		top: "5dp"
		bottom: "5dp"
		height: "50dp"
		width: "50dp"
	self.add image

	name = Ti.UI.createLabel
		text: dict.name
		left: "60dp"
		top: "10dp"
		color: "#000000"
		highlightedColor: "#FFFFFF"
		font: { fontWeight: "bold", fontSize: "16dp" }
	self.add name

	company = Ti.UI.createLabel
		text: dict.company
		left: "60dp"
		top: "30dp"
		color: "#666666"
		highlightedColor: "#FFFFFF"
		font: { fontSize: "14dp" }
	self.add company

	self


# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object