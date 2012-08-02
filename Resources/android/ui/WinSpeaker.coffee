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
		modal: true

	# Create ActionBar
	actionBar = new ActionBarView
		title: speaker.name
		titleColor: config.theme.android.actionBar.titleColor
		backgroundColor: config.theme.android.actionBar.backgroundColor
		backgroundImage: config.theme.android.actionBar.backgroundImage
		selectedColor: config.theme.android.selectedBackgroundColor
		backButton: true
	self.add actionBar

	# Create HeaderView
	headerView = Ti.UI.createView
		height: Ti.UI.SIZE
		backgroundColor: "transparent"

	# ImageProfile
	imageProfile = Ti.UI.createImageView
		image: "/images/speakers/detail/#{speaker.picture}"
		height: "65dp"
		width: "65dp"
		top: "10dp"
		left: "10dp"
		bottom: "10dp"
		borderColor: "#444444"
		borderWidth: 1
		borderRadius: 4
	headerView.add imageProfile

	# Name
	labelName = Ti.UI.createLabel
		text: speaker.name
		left: "85dp"
		top: "20dp"
		color: "#000000"
		font: { fontSize: "18dp", fontWeight: "bold"}
	headerView.add labelName

	# Company
	labelCompany = Ti.UI.createLabel
		text: speaker.company
		left: "85dp"
		top: "40dp"
		color: "#333333"
		font: { fontSize: "15dp" }
	headerView.add labelCompany

	# Rows

	# WebSite
	rowWebsite = ui.createRowWithTitleAndValue L("website"), speaker.website, true

	# Twitter
	rowTwitter = ui.createRowWithTitleAndValue L("twitter"), "@#{speaker.twitter_handle}", true

	# Description
	rowDescription = Ti.UI.createTableViewRow()

	# Select lang of text description
	locale = Ti.Platform.getLocale()

	if typeof speaker.description[locale] != "undefined"
		descriptionText = speaker.description[locale]
	else
		descriptionText = speaker.description.en

	rowDescription.add Ti.UI.createLabel
		text: descriptionText
		height: Ti.UI.SIZE
		left: "10dp"
		right: "10dp"
		top: "10dp"
		bottom: "10dp"
		ellipsize: false
		color: "#000000"
		font: { fontSize: "16dp" }

	contentView = Ti.UI.createView
		top: "44dp"
	self.add contentView

	# Create TableView
	tableView = new ui.createTableView
		headerView: headerView
		separatorColor: "#BEBEBE"
		data: [rowWebsite, rowTwitter, rowDescription]
	contentView.add tableView

	# Events handler
	actionBar.addEventListener "back", ->
		self.close()

	tableView.addEventListener "click", (e) ->
		switch e.index
			when 0 then openWebSite()
			when 1 then openTwitter()

	# Methods
	openWebSite = ->
		url = "http://www.#{speaker.website}"
		Ti.Platform.openURL url

	openTwitter = ->
		url = "http://www.twitter.com/#{speaker.twitter_handle}"
		Ti.Platform.openURL url

	self

module.exports = Window