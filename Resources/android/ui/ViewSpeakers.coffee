View = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the View
	self = new ui.createView
		backgroundColor: "#FF0000"

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	# speakers = model.getSpeakers()
	# rows = (ui.createTalkerRow speaker for speaker in speakers)
	# tableView.setData rows

	self

module.exports = View