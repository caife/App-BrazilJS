Window = (speaker) ->

	# Requirements
	ui = require "/ui/components"
	ActionBarView = require "/lib/ActionBarView"
	Model = require "/lib/Model"

	# Just initialize some variables
	model = new Model()
	config = model.getConfig()

	# Create the Window
	self = new ui.createWindow
		title: L("speaker")
		modal: false

	# Create ActionBar
	actionBar = new ActionBarView
		title: L("speaker")
		titleColor: config.theme.android.actionBar.titleColor
		backgroundColor: config.theme.android.actionBar.backgroundColor
		backgroundImage: config.theme.android.actionBar.backgroundImage
		selectedColor: config.theme.android.selectedBackgroundColor
		backButton: true
	self.add actionBar

	# Create HeaderView
	headerView = Ti.UI.createView
		top: "44dp"
		height: "85dp"
		backgroundColor: "#EEEEEE"
	self.add headerView

	# ImageProfile
	headerView.add Ti.UI.createImageView
		image: "/images/speakers/detail/#{speaker.picture}"
		height: "65dp"
		width: "65dp"
		top: "10dp"
		left: "10dp"
		bottom: "10dp"
		borderColor: "#444444"
		borderWidth: 1
		borderRadius: 4

	# Name
	headerView.add Ti.UI.createLabel
		text: speaker.name
		left: "85dp"
		top: "20dp"
		color: "#000000"
		font: { fontSize: "18dp", fontWeight: "bold"}

	# Company
	headerView.add Ti.UI.createLabel
		text: speaker.company
		left: "85dp"
		top: "40dp"
		color: "#333333"
		font: { fontSize: "15dp" }

	headerView.add Ti.UI.createView
		width: Ti.UI.FILL
		bottom: 0
		backgroundColor: "#CCCCCC"
		height: "1dp"

	# Rows

	# WebSite
	sectionWebsite = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("website")
	
	rowWebsite = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowWebsite.add Ti.UI.createLabel
		left: "13dp"
		right: "13dp"
		text: speaker.website
		font: { fontSize: "16dp" }
		color: "#000000"
		touchEnabled: false
	sectionWebsite.add rowWebsite

	# Twitter
	sectionTwitter = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("twitter")

	rowTwitter = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowTwitter.add Ti.UI.createLabel
		left: "13dp"
		right: "13dp"
		text: "@#{speaker.twitter_handle}"
		font: { fontSize: "16dp" }
		color: "#000000"
		touchEnabled: false
	sectionTwitter.add rowTwitter

	# Description
	sectionDescription = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("description")
	
	rowDescription = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"

	# Select lang of text description
	locale = Ti.Platform.getLocale()

	if typeof speaker.description[locale] != "undefined"
		descriptionText = speaker.description[locale]
	else
		descriptionText = speaker.description.en

	rowDescription.add Ti.UI.createLabel
		text: descriptionText
		height: Ti.UI.SIZE
		left: "13dp"
		right: "13dp"
		top: "10dp"
		bottom: "10dp"
		ellipsize: false
		color: "#000000"
		font: { fontSize: "16dp" }
	sectionDescription.add rowDescription

	contentView = Ti.UI.createView
		top: "129dp"
	self.add contentView

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "transparent"
		data: [sectionWebsite, sectionTwitter, sectionDescription]
	contentView.add tableView

	# Methods
	openWebsite = ->
		url = "http://www.#{speaker.website}"
		Ti.Platform.openURL url

	openTwitter = ->
		url = "http://www.twitter.com/#{speaker.twitter_handle}"
		Ti.Platform.openURL url

	# Events handler

	# ActionBar
	actionBar.addEventListener "back", ->
		self.setBackgroundColor "#FFFFFF"
		self.close()

	# WebSite
	rowWebsite.addEventListener "click", ->
		openWebsite()

	# Twitter
	rowTwitter.addEventListener "click", ->
		openTwitter()

	self

module.exports = Window