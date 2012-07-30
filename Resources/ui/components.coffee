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

	# Set barImage if configured
	if typeof config.theme.ios.barImage != "undefined"
		window.setBarImage "/images/ui/Navigation.png"

	# Set shadow in the Window if configured
	if typeof config.theme.ios.haveShadowInWindow != "undefined"
		
		if config.theme.ios.haveShadowInWindow == true

			# Create Shadow
			shadowTopView = Ti.UI.createView
				zIndex: 10
				height: 100
				width: 350
				backgroundColor: "#FF0000"
				top: -100
				shadow:
					shadowRadius: 7
					shadowOpacity: 0.5
					shadowOffset: { x: 0, y: 5 }
			window.add shadowTopView

			# Create Shadow
			shadowBottomView = Ti.UI.createView
				zIndex: 10
				height: 100
				width: 350
				backgroundColor: "#FF0000"
				top: 370
				shadow:
					shadowRadius: 7
					shadowOpacity: 0.7
					shadowOffset: { x: 0, y: -5 }
			window.add shadowBottomView

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

	spaceFromBorder = if isAndroid then 0 else "7dp"
	imageSize = if isAndroid then "70dp" else "45dp"
	leftSpaceOfLabels = if isAndroid then "85dp" else "70dp"

	self = Ti.UI.createTableViewRow
		speaker_obj: dict
		hasChild: if isAndroid then false else true
		height: Ti.UI.SIZE
		selectedBackgroundColor: config.theme.ios.selectedBackgroundColor
		className: "speaker"

	image = Ti.UI.createImageView
		image: "/images/speakers/list/#{dict.picture}"
		left: spaceFromBorder
		top: spaceFromBorder
		bottom: spaceFromBorder
		height: imageSize
		width: imageSize
	self.add image

	name = Ti.UI.createLabel
		text: dict.name
		left: leftSpaceOfLabels
		top: "11dp"
		color: "#000000"
		font: { fontWeight: "bold", fontSize: "18dp" }
	self.add name

	company = Ti.UI.createLabel
		text: dict.company
		left: leftSpaceOfLabels
		top: "31dp"
		color: "#666666"
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
		selectedBackgroundColor: config.theme.ios.selectedBackgroundColor
		height: "60dp"
		className: "talk"

	# Title
	titleLabel = Ti.UI.createLabel
		text: dict.name
		left: leftSpaceOfLabels
		top: "10dp"
		color: "#000000"
		font: { fontSize: "18dp", fontWeight: "bold" }
	self.add titleLabel

	# Time and Speaker
	timeAndSpeakerLabel = Ti.UI.createLabel
		text: "#{talkHour}:#{talkMinute} - #{dict.speaker}"
		left: leftSpaceOfLabels
		top: "33dp"
		color: "#666666"
		font: { fontSize: "14dp" }
	self.add timeAndSpeakerLabel

	self

exports.createRowWithTitleAndValue = (title, value, selectable = false, hasChild = false) ->
	
	row = Ti.UI.createTableViewRow
		height: 44
		hasChild: hasChild
		selectedBackgroundColor: if selectable then config.theme.ios.selectedBackgroundColor
		selectionStyle: if !selectable then Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
	
	row.add Ti.UI.createLabel
		text: title
		left: 10
		font: { fontSize: 16, fontWeight: "bold" }

	row.add Ti.UI.createLabel
		text: value
		right: 10
		font: { fontSize: 16 }

	row

# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object