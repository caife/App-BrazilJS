Window = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"
	ProgressView = require "/lib/ProgressView"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the Window
	self = new ui.createWindow
		title: L("talks")

	# Get data and set to rows Array
	talks = model.getTalks()
	rows = (ui.createTalkRow talk for talk in talks)

	# Create TableView
	tableView = new ui.createTableView
		data: rows
	
	self.add tableView

	progressView = new ProgressView
		bottomSpace: 44

	self.add progressView

	self

module.exports = Window