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
	xhr = Ti.Network.createHTTPClient
		onload: ->
			# Get values returned from WS and make JSON parse
			talks = JSON.parse @responseText

			# Create rows and put it to rows Array
			rows = (createTalkRow talk for talk in talks)

			# Set data in TableView
			tableView.setData rows

			# Hide ProgressView
			progressView.hide()

	xhr.open "GET", 
	xhr.send()

	# Show ProgressView
	progressView = new ProgressView
		bottomSpace: 44
	self.add progressView

	self

module.exports = Window