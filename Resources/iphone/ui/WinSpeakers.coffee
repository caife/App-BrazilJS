Window = (dict) ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rowSelected = null
	rowSelectedIndex = null
	rows = []

	# Create the Window
	self = new ui.createWindow
		title: L("speakers")

	# Get data and set to rows Array
	speakers = model.getSpeakers()
	rows = (ui.createSpeakerRow speaker for speaker in speakers)

	# Create TableView
	tableView = new ui.createTableView
		data: rows

	self.add tableView

	# Events handler
	tableView.addEventListener "click", (e) ->

		# Select row
		rowSelectedIndex = e.index
		rowSelected = e.row
		tableView.selectRow(e.index, { animated : false })
		
		# Open Window
		speaker_obj = e.rowData.speaker_obj

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