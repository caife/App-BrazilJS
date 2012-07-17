Window = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"

	# Instance Model object
	model = new Model()
	rows = []

	# Create the Window
	self = new ui.createWindow
		title: L("twitter")

	self

module.exports = Window