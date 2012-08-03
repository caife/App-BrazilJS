View = ->

	# Requirements
	Model = require "/lib/Model"
	ui = require "/ui/components"
	NYDate = require "/lib/NYDate"

	# Instance Model object
	model = new Model()
	config = model.getConfig()

	# Create the View
	self = ui.createView
		backgroundColor: "#FFFFFF"

	# ActivityIndicator
	progressView = undefined

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "#BEBEBE"
	self.add tableView

	# Get Talks from WS (online)
	getDataFromWS = ->
		# Disable Refresh Button
		#buttonRefresh.setEnabled false

		# Show ProgressView
		progressView = Ti.UI.createActivityIndicator
			message: L("loading")
		self.add progressView
		
		progressView.show()

		# Start to get values from WS
		xhr = Ti.Network.createHTTPClient
			oncancel: ->
				# Enable Refresh Button
				#buttonRefresh.setEnabled true
				
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
		#buttonRefresh.setEnabled false

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
				talkDate = new NYDate(talk.dateTime)
				talkDay = talkDate.getDay()
				talkMonth = talkDate.getMonth() + 1

				# Create TableViewRow
				row = ui.createTalkRow talk

				# If is a different day, create a new Section
				if talkDay != beforeTalkDay
					beforeTalkDay = talkDay
					actualSection = "#{talkDay}#{talkMonth}"

					if typeof sections[actualSection] == "undefined"
						sections[actualSection] = Ti.UI.createTableViewSection
							headerTitle: talkDate.getDayAndStringMonth()

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
		#buttonRefresh.setEnabled true


	# Get data
	if Ti.Network.networkType != 0
		# Get data from WS
		getDataFromWS()
	else
		# Get data from Model
		getDataFromLocal()

	# Events handler

	# TableView Click
	tableView.addEventListener "click", (e) ->

		talk_obj = e.row.talk_obj

		if talk_obj.type == "talk"
			# Open Window
			WinTalk = require "/ui/WinTalk"
			new WinTalk(talk_obj).open()

	self

module.exports = View