Window = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
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

	self

module.exports = Window