NYDate = require "/lib/NYDate"
Model = require "/lib/Model"
model = new Model()
config = model.getConfig()
locale = Ti.Platform.getLocale()

# Defaults
isAndroid = if (Ti.Platform.osname == "android") then true else false
gradientColor = config.theme.ios.barColor


# Window
exports.createWindow = (dict) ->

	defaults = 
		backgroundColor: "#FFFFFF"
		barColor: gradientColor
		navBarHidden: if isAndroid then true else false

	window = Ti.UI.createWindow applyConfig dict, defaults

	# Set barImage if configured
	if !isAndroid and typeof config.theme.ios.barImage != "undefined"
		window.setBarImage "/images/ui/Navigation.png"

	# Set shadow in the Window if configured
	if !isAndroid and typeof config.theme.ios.haveShadowInWindow != "undefined"
		
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

	spaceFromBorder = "7dp"
	imageSize = "45dp"
	leftSpaceOfLabels = "70dp"

	self = Ti.UI.createTableViewRow
		speaker_obj: dict
		hasChild: if isAndroid then false else true
		height: Ti.UI.SIZE
		focusable: true
		className: "speaker"

	if !isAndroid
		self.selectedBackgroundColor = config.theme.ios.selectedBackgroundColor

	image = Ti.UI.createImageView
		image: "/images/speakers/list/#{dict.picture}"
		left: spaceFromBorder
		top: spaceFromBorder
		bottom: spaceFromBorder
		height: imageSize
		width: imageSize
		touchEnabled: false
	self.add image

	name = Ti.UI.createLabel
		text: dict.name
		left: leftSpaceOfLabels
		top: "11dp"
		color: "#000000"
		font: { fontWeight: "bold", fontSize: "18dp" }
		touchEnabled: false
	self.add name

	company = Ti.UI.createLabel
		text: dict.company
		left: leftSpaceOfLabels
		top: "31dp"
		color: "#666666"
		font: { fontSize: "14dp" }
		touchEnabled: false
	self.add company

	self

exports.createTalkRow = (dict) ->

	leftSpaceOfLabels = "10dp"

	# Instance of NYDate
	talkDate = new NYDate(dict.dateTime)

	# TableViewRow
	self = Ti.UI.createTableViewRow
		talk_obj: dict
		hasChild: if isAndroid or dict.type != "talk" then false else true
		height: Ti.UI.SIZE
		layout: "vertical"
		className: "talk"

	if !isAndroid
		self.selectedBackgroundColor = config.theme.ios.selectedBackgroundColor

	if isAndroid and dict.type != "talk"
		self.backgroundSelectedColor = "transparent"

	if !isAndroid and dict.type != "talk"
		self.selectionStyle = Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	# Select lang of text name
	if typeof dict.name[locale] != "undefined"
		nameText = dict.name[locale]
	else
		nameText = dict.name.en

	# Title
	titleLabel = Ti.UI.createLabel
		text: nameText
		left: leftSpaceOfLabels
		top: "10dp"
		color: "#000000"
		font: { fontSize: "18dp", fontWeight: "bold" }
		touchEnabled: false
	self.add titleLabel

	# Time and Speaker
	if dict.talk == true
		timeText = "#{talkDate.getFormatedTime()} - #{dict.speaker}"
	else
		timeText = talkDate.getFormatedTime()

	timeAndSpeakerLabel = Ti.UI.createLabel
		text: timeText
		left: leftSpaceOfLabels
		bottom: "12dp"
		top: "5dp"
		height: "15dp"
		color: "#666666"
		font: { fontSize: "14dp" }
		touchEnabled: false
	self.add timeAndSpeakerLabel

	# Right image, if needed
	if dict.type != "talk"
		
		switch dict.type
			when "coffee", "breakfast", "other"
				rightImageOfRow = "Coffee.png"
			when "lunch"
				rightImageOfRow = "Food.png"
			when "checkin/breakfast"
				rightImageOfRow = "Tag.png"
			when "break"
				rightImageOfRow = "User.png"
			else
				rightImageOfRow = "Coffee.png"

		self.setRightImage "/images/icons/#{rightImageOfRow}"

	self

exports.createRowWithTitleAndValue = (title, value, selectable = false, hasChild = false) ->
	
	row = Ti.UI.createTableViewRow
		height: if isAndroid then "50dp" else "44dp"
		hasChild: hasChild
		selectionStyle: if !selectable then Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	if !isAndroid
		row.selectedBackgroundColor = if selectable then config.theme.ios.selectedBackgroundColor
	
	row.add Ti.UI.createLabel
		text: title
		left: if isAndroid then 0 else "10dp"
		font: { fontSize: "16dp", fontWeight: "bold" }
		color: "#000000"

	row.add Ti.UI.createLabel
		text: value
		right: if isAndroid then 0 else "10dp"
		font: { fontSize: "16dp" }
		color: "#000000"

	row

exports.createSectionHeaderView = (title) ->

	self = Ti.UI.createView
		width: Ti.UI.SIZE
		height: "40dp"
		backgroundColor: "transparent"

	self.add Ti.UI.createView
		left: "13dp"
		right: "13dp"
		bottom: 0
		height: "1dp"
		backgroundColor: "#000000"

	self.add Ti.UI.createLabel
		text: title
		left: "13dp"
		right: "13dp"
		bottom: "3dp"
		color: "#000000"
		height: "17dp"
		font: { fontSize: "14dp", fontWeight: "bold" }

	self


# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object