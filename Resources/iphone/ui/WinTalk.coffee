Window = (dict, talk) ->

	# Requirements
	ui = require "/ui/components"
	Model = require "/lib/Model"
	NYDate = require "/lib/NYDate"

	# Just initialize some variables
	model = new Model()
	config = model.getConfig()
	rowSelectedIndex = null
	locale = Ti.Platform.getLocale()

	# Instance of NYDate
	talkDate = new NYDate(talk.dateTime)

	# Create the Window
	self = new ui.createWindow
		title: L("talk")

	# Create HeaderView
	headerView = Ti.UI.createView
		height: Ti.UI.SIZE
		backgroundColor: "transparent"

	# Select lang of text name
	if typeof talk.name[locale] != "undefined"
		nameText = talk.name[locale]
	else
		nameText = talk.name.en

	# Name
	labelName = Ti.UI.createLabel
		text: nameText
		right: 20
		left: 20
		top: 20
		color: "#000000"
		shadowColor: "#FFFFFF"
		shadowOffset: { x: 0, y: 1}
		font: { fontSize: 18, fontWeight: "bold"}
	headerView.add labelName

	# Rows

	# Speaker
	rowSpeaker = ui.createRowWithTitleAndValue L("speaker"), talk.speaker, true, true

	# Date
	rowDate = ui.createRowWithTitleAndValue L("date"), talkDate.getDayAndStringMonth()

	# Time
	rowTime = ui.createRowWithTitleAndValue L("time"), talkDate.getFormatedTime()

	# Description
	rowDescription = Ti.UI.createTableViewRow
		selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	# Select lang of text description
	if typeof talk.description[locale] != "undefined"
		descriptionText = talk.description[locale]
	else
		descriptionText = talk.description.en

	rowDescription.add Ti.UI.createLabel
		text: descriptionText
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
		data: [rowSpeaker, rowDate, rowTime, rowDescription]

	self.add tableView

	# Events
	tableView.addEventListener "click", (e) ->

		if e.index == 0

			speaker_obj = model.getSpeakerWithName talk.speaker

			# Select row
			rowSelectedIndex = e.index
			tableView.selectRow(e.index, { animated : false })

			WinSpeaker = require "/ui/WinSpeaker"
			winSpeaker = new WinSpeaker(speaker_obj)
			dict.currenTab.open winSpeaker

	# Deselect row
	self.addEventListener "focus", ->
		setTimeout(->
			if rowSelectedIndex != null
				tableView.deselectRow(rowSelectedIndex, { duration: 150 })
		, 100)

	self

module.exports = Window