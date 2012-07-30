Window = (dict) ->

	# Requirements
	ui = require "/ui/components"
	ProgressView = require "/lib/ProgressView"
	Model = require "/lib/Model"

	model = new Model()
	config = model.getConfig()
		
	rowSelectedIndex = null
	rowSelected = null
	rows = []
	months = [
		L("january")
		L("february")
		L("march")
		L("april")
		L("may")
		L("june")
		L("july")
		L("august")
		L("september")
		L("october")
		L("november")
		L("december")
	]

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

					# Create TableViewRow
					row = ui.createTalkRow talk

					# If is a different day, create a new Section
					if talkDay != beforeTalkDay
						beforeTalkDay = talkDay
						actualSection = "#{talkDay}#{talkMonth}"

						if typeof sections[actualSection] == "undefined"
							sections[actualSection] = Ti.UI.createTableViewSection
								headerTitle: "#{talkDay} #{L('of')} #{months[talkMonth]}"

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

	xhr.open "GET", config.ws.talks
	xhr.send()

	# Show ProgressView
	progressView = new ProgressView
		bottomSpace: 44
	self.add progressView

	# Events handler
	tableView.addEventListener "click", (e) ->

		# Select row
		rowSelectedIndex = e.index
		rowSelected = e.row
		tableView.selectRow(e.index, { animated : false })
		
		# Open Window
		talk_obj = e.rowData.talk_obj

		WinTalk = require "/ui/WinTalk"
		winTalk = new WinTalk(dict, talk_obj)
		dict.currenTab.open winTalk


	# Deselect row
	self.addEventListener "focus", ->
		setTimeout(->
			if rowSelectedIndex != null
				tableView.deselectRow(rowSelectedIndex, { duration: 150 })
		, 100)

	self

module.exports = Window