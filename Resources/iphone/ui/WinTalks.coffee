Window = ->

	# Requirements
	ui = require "/ui/components"
	ProgressView = require "/lib/ProgressView"

	rows = []

	# Create the Window
	self = new ui.createWindow
		title: L("talks")

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	# Start to get values from WS

	# Show ProgressView
	progressView = new ProgressView
		bottomSpace: 44
	self.add progressView

	self

module.exports = Window