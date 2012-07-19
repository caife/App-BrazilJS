Window = (speaker) ->

	# Requirements
	ui = require "/ui/components"

	# Create the Window
	self = new ui.createWindow
		title: L("speaker")

	# Create HeaderView
	headerView = Ti.UI.createView
		height: Ti.UI.SIZE
		backgroundColor: "transparent"

	# ImageProfile
	imageProfile = Ti.UI.createImageView
		image: "/images/speakers/#{speaker.picture}"
		height: 65
		width: 65
		top: 10
		left: 10
		borderColor: "#444444"
		borderWidth: 1
		borderRadius: 4
	headerView.add imageProfile

	# Name
	labelName = Ti.UI.createLabel
		text: speaker.name
		left: 85
		top: 20
		color: "#000000"
		shadowColor: "#FFFFFF"
		shadowOffset: { x: 0, y: 1}
		font: { fontSize: 18, fontWeight: "bold"}
	headerView.add labelName

	# Company
	labelCompany = Ti.UI.createLabel
		text: speaker.company
		left: 85
		top: 40
		color: "#333333"
		shadowColor: "#FFFFFF"
		shadowOffset: { x: 0, y: 1}
		font: { fontSize: 15 }
	headerView.add labelCompany

	# Rows

	# Twitter
	rowTwitter = Ti.UI.createTableViewRow
		height: 44
	
	rowTwitter.add Ti.UI.createLabel
		text: L("twitter")
		left: 10
		font: { fontSize: 16, fontWeight: "bold" }

	rowTwitter.add Ti.UI.createLabel
		text: "@#{speaker.twitter_handle}"
		right: 10
		font: { fontSize: 16 }

	# Description
	rowDescription = Ti.UI.createTableViewRow
		selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	rowDescription.add Ti.UI.createLabel
		text: speaker.description
		width: 280
		height: Ti.UI.SIZE
		top: 10
		bottom: 10
		ellipsize: false
		font: { fontSize: 16 }

	# Create TableView
	tableView = new ui.createTableView
		headerView: headerView
		style: Ti.UI.iPhone.TableViewStyle.GROUPED
		data: [rowTwitter, rowDescription]

	self.add tableView

	self

module.exports = Window