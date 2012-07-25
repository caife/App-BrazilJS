Window = (speaker) ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the View
	self = ui.createWindow
		backgroundColor: "#FFFFFF"

	self.add tableView

	self

module.exports = Window