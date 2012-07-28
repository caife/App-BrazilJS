Model = require "/lib/Model"
model = new Model()
config = model.getConfig()

# Defaults
isAndroid = if (Ti.Platform.osname == "android") then true else false
gradientColor = config.theme.ios.barColor


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

	spaceFromBorder = if isAndroid then 0 else "5dp"
	imageSize = if isAndroid then "70dp" else "60dp"
	leftSpaceOfLabels = if isAndroid then "85dp" else "70dp"

	self = Ti.UI.createTableViewRow
		speaker_obj: dict
		hasChild: if isAndroid then false else true
		height: Ti.UI.SIZE
		className: "speaker"

	image = Ti.UI.createImageView
		image: "/images/speakers/#{dict.picture}"
		left: spaceFromBorder
		top: spaceFromBorder
		bottom: spaceFromBorder
		height: imageSize
		width: imageSize
	self.add image

	name = Ti.UI.createLabel
		text: dict.name
		left: leftSpaceOfLabels
		top: "14dp"
		color: "#000000"
		highlightedColor: "#FFFFFF"
		font: { fontWeight: "bold", fontSize: "18dp" }
	self.add name

	company = Ti.UI.createLabel
		text: dict.company
		left: leftSpaceOfLabels
		top: "35dp"
		color: "#666666"
		highlightedColor: "#FFFFFF"
		font: { fontSize: "14dp" }
	self.add company

	self

exports.createTalkRow = (dict) ->

	leftSpaceOfLabels = "10dp"

	# Separate data to get day
	talkDate = new Date(dict.dateTime)
	talkHour = talkDate.getHours()
	talkMinute = talkDate.getMinutes()

	talkHour = "0#{talkHour}" if talkHour < 10
	talkMinute = "0#{talkMinute}" if talkMinute < 10

	# TableViewRow
	self = Ti.UI.createTableViewRow
		talk_obj: dict
		hasChild: if isAndroid then false else true
		height: "60dp"
		className: "talk"

	# Title
	titleLabel = Ti.UI.createLabel
		text: dict.name
		left: leftSpaceOfLabels
		top: "10dp"
		color: "#000000"
		highlightedColor: "#FFFFFF"
		font: { fontSize: "18dp", fontWeight: "bold" }
	self.add titleLabel

	# Time and Speaker
	timeAndSpeakerLabel = Ti.UI.createLabel
		text: "#{talkHour}:#{talkMinute} - #{dict.speaker}"
		left: leftSpaceOfLabels
		top: "33dp"
		color: "#999999"
		highlightedColor: "#FFFFFF"
		font: { fontSize: "14dp" }
	self.add timeAndSpeakerLabel

	self

# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object