View = ->

	# Requirements
	Model = require "/lib/Model"
	Location = require "/lib/Location"
	ui = require "/ui/components"

	# Instance Model object and get config informations
	model = new Model()
	config = model.getConfig()
	location = config.location

	# Create the View
	self = new ui.createView
		backgroundColor: "#FFFFFF"

	# HeaderView (view in maps)
	headerView = Ti.UI.createView
		top: 0
		height: "70dp"
		backgroundColor: "#EEEEEE"
	self.add headerView

	headerView.add Ti.UI.createImageView
		image: "/images/icons/Navigation-Map.png"
		width: "35dp"
		height: "35dp"
		left: "20dp"

	headerView.add Ti.UI.createLabel
		text: L("view_map")
		color: "#000000"
		font: { fontSize: "16dp", fontWeight: "bold" }

	headerView.add Ti.UI.createView
		width: Ti.UI.FILL
		bottom: 0
		backgroundColor: "#CCCCCC"
		height: "1dp"

	# Rows

	# Location
	sectionLocation = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("location")
	
	rowLocation = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowLocation.add Ti.UI.createLabel
		left: "13dp"
		right: "13dp"
		text: location.name
		font: { fontSize: "16dp" }
		color: "#000000"
	
	sectionLocation.add rowLocation

	# Address
	sectionAddress = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("address")
	
	rowAddress = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowAddress.add Ti.UI.createLabel
		left: "13dp"
		right: "13dp"
		text: location.address
		font: { fontSize: "16dp" }
		color: "#000000"
	
	sectionAddress.add rowAddress

	# Address
	sectionRegion = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("city")
	
	rowRegion = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowRegion.add Ti.UI.createLabel
		left: "13dp"
		right: "13dp"
		text: "#{location.city} / #{location.state} - #{location.country}"
		font: { fontSize: "16dp" }
		color: "#000000"
	
	sectionRegion.add rowRegion

	# TableView
	contentView = Ti.UI.createView
		top: "70dp"
	self.add contentView

	tableView = new ui.createTableView
		separatorColor: "transparent"
		data: [sectionLocation, sectionAddress, sectionRegion]
	contentView.add tableView

	# Events handler
	headerView.addEventListener "click", ->
		Location.makeRoute location.latitude, location.longitude

	headerView.addEventListener "touchstart", ->
		@setBackgroundColor config.theme.android.selectedBackgroundColor

	headerView.addEventListener "touchend", ->
		@setBackgroundColor "#EEEEEE"

	headerView.addEventListener "touchcancel", ->
		@setBackgroundColor "#EEEEEE"

	self

module.exports = View