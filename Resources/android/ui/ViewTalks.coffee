View = (App) ->

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

	# Create TableView
	tableView = new ui.createTableView
		separatorColor: "#BEBEBE"
	self.add tableView

	# Get Talks from WS (online)
	getDataFromWS = ->

		# Start to get values from WS
		xhr = Ti.Network.createHTTPClient
			oncancel: ->
				return

			onerror: ->
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

		App.fireEvent("hideProgressView")

	# LoadData
	loadData = ->

		App.fireEvent("showProgressView")

		if Ti.Network.networkType != 0
			getDataFromWS()
		else
			getDataFromLocal()
	

	# Events handler

	# TableView Click
	tableView.addEventListener "click", (e) ->

		talk_obj = e.row.talk_obj

		if talk_obj.type == "talk"
			# Open Window
			WinTalk = require "/ui/WinTalk"
			new WinTalk(talk_obj).open()

	# Refresh List
	self.addEventListener "refreshList", ->
		loadData()

	loadData()

	self

module.exports = View