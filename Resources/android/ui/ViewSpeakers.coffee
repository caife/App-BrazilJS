View = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the View
	self = ui.createView
		backgroundColor: "#FFFFFF"

	# Get data and set to rows Array
	speakers = model.getSpeakers()
	sectionSpeakers = Ti.UI.createTableViewSection()

	sectionSpeakers.add ui.createSpeakerRow speaker for speaker in speakers

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "#BEBEBE"
		data: [sectionSpeakers]

	self.add tableView

	# Events handle
	tableView.addEventListener "click", (e) ->

		speaker_obj = e.row.speaker_obj

		WinSpeaker = require "/ui/WinSpeaker"
		new WinSpeaker(speaker_obj).open()

	self

module.exports = View