View = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the View
	self = new ui.createView
		backgroundColor: "#0000FF"

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	self

module.exports = View