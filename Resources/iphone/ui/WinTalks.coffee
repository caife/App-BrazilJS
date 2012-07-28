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
		onerror: ->
			Ti.UI.createAlertDialog
				title: L("connection")
				message: L("connection_failed")
			.show()

			progressView.hide()

		onload: ->
			# Get values returned from WS and make JSON parse
			talks = JSON.parse @responseText
			beforeTalkDay = 0
			actualSection = null
			sections = {}

			for talk in talks
				do (talk) ->

					# Separate data to get day
					talkDate = new Date(talk.dateTime)
					talkDay = talkDate.getDate()
					talkMonth = talkDate.getMonth() + 1
					talkYear = talkDate.getFullYear()

					# Create TableViewRow
					row = ui.createTalkRow talk

					# If is a different day, create a new Section
					if talkDay != beforeTalkDay
						beforeTalkDay = talkDay
						actualSection = "#{talkDay}/#{talkYear}"

						if typeof sections[actualSection] == "undefined"
							sections[actualSection] = Ti.UI.createTableViewSection
								headerTitle: "#{talkDay}/#{talkMonth}/#{talkYear}"

					sections[actualSection].add row

			# Create a Sections list
			sectionsList = []
			for section of sections
				do (section) ->
					sectionsList.push sections[section]

			# Set data in TableView
			tableView.setData sectionsList

			# Hide ProgressView
			progressView.hide()

	xhr.open "GET", "http://braziljs-ws.herokuapp.com/talks"
	xhr.send()

	# Show ProgressView
	progressView = new ProgressView
		bottomSpace: 44
	self.add progressView

	self

module.exports = Window