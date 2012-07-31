Window = (dict) ->

	# Requirements
	ui = require "/ui/components"
	ProgressView = require "/lib/ProgressView"
	Model = require "/lib/Model"

	model = new Model()
	config = model.getConfig()
		
	rowSelectedIndex = null
	rowSelected = null
	progressView = undefined
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

	buttonRefresh = Ti.UI.createButton
		systemButton: Ti.UI.iPhone.SystemButton.REFRESH
		enabled: false

	# Create the Window
	self = new ui.createWindow
		rightNavButton: buttonRefresh
		title: L("talks")

	# Create TableView
	tableView = new ui.createTableView()
	self.add tableView

	# Get Talks from WS (online)
	getDataFromWS = ->
		# Disable Refresh Button
		buttonRefresh.setEnabled false

		# Show ProgressView
		progressView = new ProgressView
			bottomSpace: 44
		self.add progressView

		# Start to get values from WS
		xhr = Ti.Network.createHTTPClient
			oncancel: ->
				# Enable Refresh Button
				buttonRefresh.setEnabled true
				
			onerror: ->
				# Hide ProgressView
				progressView.hide()

				# Get local data
				getDataFromLocal()

			onload: ->
				# Get values returned from WS and make JSON parse
				talks = JSON.parse @responseText

				# Overwrite model values
				model.setTalks talks

				# Construct rows
				constructRows talks

		# Execute request
		xhr.open "GET", config.ws.talks
		xhr.send()


	# Get Talks from Properties (offline)
	getDataFromLocal = ->
		# Disable Refresh Button
		buttonRefresh.setEnabled false

		# Get Properties
		talks = model.getTalks()

		# Construct rows
		constructRows talks


	# Construct the UI
	constructRows = (data) ->
		beforeTalkDay = 0
		actualSection = null
		sections = {}

		for talk in data
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
		if typeof progressView != "undefined"
			progressView.hide()

		# Enable Refresh Button
		buttonRefresh.setEnabled true


	# Get data
	if Ti.Network.getOnline() == false
		# Get data from WS
		getDataFromWS()
	else
		# Get data from Model
		getDataFromLocal()


	# Events handler

	# TableView Click
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


	# Refresh Button click
	buttonRefresh.addEventListener "click", ->

		if Ti.Network.getOnline() == true
			# Get data from WS
			getDataFromWS()
		else
			# Get data from Model
			getDataFromLocal()


	# Deselect row
	self.addEventListener "focus", ->
		setTimeout(->
			if rowSelectedIndex != null
				tableView.deselectRow(rowSelectedIndex, { duration: 150 })
		, 100)

	self

module.exports = Window