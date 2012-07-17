Window = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the Window
	self = new ui.createView()

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	speakers = model.getSpeakers()
	rows = (ui.createTalkerRow speaker for speaker in speakers)
	tableView.setData rows

	self

module.exports = Window