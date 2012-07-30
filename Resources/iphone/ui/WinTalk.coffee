Window = (dict, talk) ->

	# Requirements
	ui = require "/ui/components"
	Model = require "/lib/Model"

	# Just initialize some variables
	model = new Model()
	config = model.getConfig()
	rowSelectedIndex = null
	months = [
		L("january")
		L("february")
		L("march")
		L("april")
		L("may")
		L("june")
		L("july")
		L("august")
		L("september")
		L("october")
		L("november")
		L("december")
	]

	# Date format
	talkDate = new Date(talk.dateTime)
	talkHour = talkDate.getHours()
	talkMinutes = talkDate.getMinutes()
	talkDay = talkDate.getDate()
	talkMonth = talkDate.getMonth() + 1
	
	talkHour = "0#{talkHour}" if talkHour < 10
	talkMinutes = "0#{talkMinutes}" if talkMinutes < 10

	timeLabelText = "#{talkHour}:#{talkMinutes}"
	dateLabelText = "#{talkDay} #{L('of')} #{months[talkMonth]}"

	# Create the Window
	self = new ui.createWindow
		title: L("talk")

	# Create HeaderView
	headerView = Ti.UI.createView
		height: Ti.UI.SIZE
		backgroundColor: "transparent"

	# Name
	labelName = Ti.UI.createLabel
		text: talk.name
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
	rowDate = ui.createRowWithTitleAndValue L("date"), dateLabelText

	# Time
	rowTime = ui.createRowWithTitleAndValue L("time"), timeLabelText

	# Description
	rowDescription = Ti.UI.createTableViewRow
		selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	rowDescription.add Ti.UI.createLabel
		text: talk.description
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