Window = (talk) ->

	# Requirements
	ui = require "/ui/components"
	ActionBarView = require "/lib/ActionBarView"
	Model = require "/lib/Model"
	NYDate = require "/lib/NYDate"

	# Just initialize some variables
	model = new Model()
	config = model.getConfig()
	locale = Ti.Platform.getLocale()
	speaker_obj = model.getSpeakerWithName talk.speaker

	# Instance of NYDate
	talkDate = new NYDate(talk.dateTime)

	# Create the Window
	self = new ui.createWindow
		title: L("talk")
		modal: true

	# Create ActionBar
	actionBar = new ActionBarView
		title: L("talk")
		titleColor: config.theme.android.actionBar.titleColor
		backgroundColor: config.theme.android.actionBar.backgroundColor
		backgroundImage: config.theme.android.actionBar.backgroundImage
		selectedColor: config.theme.android.selectedBackgroundColor
		backButton: true
		buttons:[{
			icon: "/images/Share.png"
			id: "share"
			width: 60
		}]
	self.add actionBar

	# Create HeaderView
	headerView = Ti.UI.createView
		top: "44dp"
		height: "95dp"
		backgroundColor: "#EEEEEE"
	self.add headerView

	# Select lang of text name
	if typeof talk.name[locale] != "undefined"
		nameText = talk.name[locale]
	else
		nameText = talk.name.en

	labelsView = Ti.UI.createView
		top: 0
		height: Ti.UI.FILL
		layout: "vertical"
	headerView.add labelsView

	# Name
	labelsView.add Ti.UI.createLabel
		text: nameText
		left: "10dp"
		right: "10dp"
		top: "10dp"
		color: "#000000"
		font: { fontSize: "20dp", fontWeight: "bold"}

	# Date
	labelsView.add Ti.UI.createLabel
		text: "#{talkDate.getDayAndStringMonth()} - #{talkDate.getFormatedTime()}"
		left: "10dp"
		right: "10dp"
		top: "5dp"
		color: "#666666"
		font: { fontSize: "14dp"}

	headerView.add Ti.UI.createView
		width: Ti.UI.FILL
		bottom: 0
		backgroundColor: "#CCCCCC"
		height: "1dp"

	# Rows

	# Speaker
	sectionSpeaker = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("speaker")
	
	rowSpeaker = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"
		height: "44dp"

	rowSpeaker.add Ti.UI.createImageView
		left: "13dp"
		width: "30dp"
		height: "30dp"
		image: "/images/speakers/detail/#{speaker_obj.picture}"

	rowSpeaker.add Ti.UI.createLabel
		left: "48dp"
		right: "13dp"
		text: talk.speaker
		font: { fontSize: "16dp" }
		color: "#000000"
	
	sectionSpeaker.add rowSpeaker

	# Description
	sectionDescription = Ti.UI.createTableViewSection
		headerView: ui.createSectionHeaderView L("description")
	
	rowDescription = Ti.UI.createTableViewRow
		selectedBackgroundColor: "transparent"

	# Select lang of text description
	if typeof talk.description[locale] != "undefined"
		descriptionText = talk.description[locale]
	else
		descriptionText = talk.description.en

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

	contentTableView = Ti.UI.createView
		top: "139dp"
	self.add contentTableView

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "transparent"
		data: [sectionSpeaker, sectionDescription]
	contentTableView.add tableView

	# Events handler
	actionBar.addEventListener "back", ->
		self.close()

	actionBar.addEventListener "buttonPress", (e) ->

		if e.id == "share"
			
			intent = Ti.Android.createIntent
				action: Ti.Android.ACTION_SEND
				type: "text/plain"

			share_message = "
					\"#{nameText}\" #{L('in_male')} @#{config.twitter_handle},
					#{L('with')} #{speaker_obj.name} - @#{speaker_obj.twitter_handle}
				"

			intent.putExtra Ti.Android.EXTRA_TEXT, share_message
			intent.addCategory Ti.Android.CATEGORY_DEFAULT
			Ti.Android.currentActivity.startActivity intent

	# Open Speaker Window
	rowSpeaker.addEventListener "click", ->
		WinSpeaker = require "/ui/WinSpeaker"
		new WinSpeaker(speaker_obj).open()

	self

module.exports = Window