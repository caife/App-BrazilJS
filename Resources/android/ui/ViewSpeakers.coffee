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
	rows = (ui.createSpeakerRow speaker for speaker in speakers)

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "#BEBEBE"
		data: rows

	self.add tableView

	self

module.exports = View