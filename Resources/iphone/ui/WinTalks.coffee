Window = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the Window
	self = new ui.createWindow
		title: L("talks")

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	self

module.exports = Window