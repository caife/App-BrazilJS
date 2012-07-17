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
		top: if isAndroid then 94 else 0

	mapView = Ti.Map.createView applyConfig dict, defaults

	mapView

# MapAnnotation
exports.createMapAnnotation = (dict) ->

	defaults = 
		draggable: false
		animate: true
		pinColor: Ti.Map.ANNOTATION_GREEN

	annotation = Ti.Map.createAnnotation applyConfig dict, defaults

	annotation


# TableView
exports.createTableView = (dict) ->

	defaults = 
		top: if isAndroid then 94 else 0

	tableView = Ti.UI.createTableView applyConfig dict, defaults

	tableView


# TableViewRows
exports.createTalkerRow = (dict) ->

	self = Ti.UI.createTableViewRow
		title: dict.name

	self


# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object