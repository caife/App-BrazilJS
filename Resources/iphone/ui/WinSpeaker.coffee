Window = (speaker) ->

	# Requirements
	ui = require "/ui/components"

	# Just initialize some variables
	rowSelectedIndex = null

	# Create the Window
	self = new ui.createWindow
		title: L("speaker")

	# Create HeaderView
	headerView = Ti.UI.createView
		height: Ti.UI.SIZE
		backgroundColor: "transparent"

	# ImageProfile
	imageProfile = Ti.UI.createImageView
		image: "/images/speakers/detail/#{speaker.picture}"
		height: 65
		width: 65
		top: 10
		left: 10
		borderColor: "#444444"
		borderWidth: 1
		borderRadius: 4
	headerView.add imageProfile

	# Name
	labelName = Ti.UI.createLabel
		text: speaker.name
		left: 85
		top: 20
		color: "#000000"
		shadowColor: "#FFFFFF"
		shadowOffset: { x: 0, y: 1}
		font: { fontSize: 18, fontWeight: "bold"}
	headerView.add labelName

	# Company
	labelCompany = Ti.UI.createLabel
		text: speaker.company
		left: 85
		top: 40
		color: "#333333"
		shadowColor: "#FFFFFF"
		shadowOffset: { x: 0, y: 1}
		font: { fontSize: 15 }
	headerView.add labelCompany

	# Rows

	# WebSite
	rowWebsite = Ti.UI.createTableViewRow
		height: 44
	
	rowWebsite.add Ti.UI.createLabel
		text: L("website")
		left: 10
		highlightedColor: "#FFFFFF"
		font: { fontSize: 16, fontWeight: "bold" }

	rowWebsite.add Ti.UI.createLabel
		text: speaker.website
		right: 10
		highlightedColor: "#FFFFFF"
		font: { fontSize: 16 }

	# Twitter
	rowTwitter = Ti.UI.createTableViewRow
		height: 44
	
	rowTwitter.add Ti.UI.createLabel
		text: L("twitter")
		left: 10
		highlightedColor: "#FFFFFF"
		font: { fontSize: 16, fontWeight: "bold" }

	rowTwitter.add Ti.UI.createLabel
		text: "@#{speaker.twitter_handle}"
		right: 10
		highlightedColor: "#FFFFFF"
		font: { fontSize: 16 }

	# Description
	rowDescription = Ti.UI.createTableViewRow
		selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE

	rowDescription.add Ti.UI.createLabel
		text: speaker.description
		width: 280
		height: Ti.UI.SIZE
		top: 10
		bottom: 10
		ellipsize: false
		font: { fontSize: 16 }

	# Create TableView
	tableView = new ui.createTableView
		headerView: headerView
		style: Ti.UI.iPhone.TableViewStyle.GROUPED
		data: [rowWebsite, rowTwitter, rowDescription]

	self.add tableView

	tableView.addEventListener "click", (e) ->

		# Select row
		if e.index == 0 or e.index == 1
			rowSelectedIndex = e.index
			tableView.selectRow(e.index, { animated : false })

		switch e.index
			when 0 then openWebsite()
			when 1 then openTwitter()

	deselectRow = (timeout = 100) ->
		setTimeout(->
			if rowSelectedIndex != null
				tableView.deselectRow(rowSelectedIndex, { duration: 150 })
		, timeout)

	# Deselect row when focus in Window
	self.addEventListener "focus", ->
		deselectRow(100)

	openWebsite = ->
		
		MiniBrowser = require "/lib/MiniBrowser"
		miniBrowser = new MiniBrowser
			modal: true
			url: "http://www.#{speaker.website}/"

		miniBrowser.open()

	openTwitterInMiniBrowser = ->

		MiniBrowser = require "/lib/MiniBrowser"
		miniBrowser = new MiniBrowser
		 	modal: true
		 	url: "http://www.twitter.com/#{speaker.twitter_handle}"

		miniBrowser.open()

	openTwitter = ->

		canOpenTwitter = false
		canOpenTweetbot = false
		options = []

		# Create URL Schema
		twitterURL = "twitter://user?screen_name=#{speaker.twitter_handle}"
		tweetbotURL = "tweetbot:///user_profile/#{speaker.twitter_handle}"

		# Verify if user have Tweetbot
		if Ti.Platform.canOpenURL tweetbotURL
			canOpenTweetbot = true
			options.push L("open_tweetbot")

		# Verify if user have Twitter
		if Ti.Platform.canOpenURL twitterURL
			canOpenTwitter = true
			options.push L("open_twitter")

		options.push L("open_in_browser")
		options.push L("cancel")

		# Create OptionDialog
		twitterOptionsDialog = Ti.UI.createOptionDialog
			title: L("how_want_you_open")
			options: options
			destructive: options.length - 1

		# Show it
		twitterOptionsDialog.show()

		# Event handler
		twitterOptionsDialog.addEventListener "click", (e) ->

			switch e.index

				when 0
					if canOpenTweetbot
						Ti.Platform.openURL tweetbotURL
						deselectRow 0
					else if canOpenTwitter
						Ti.Platform.openURL twitterURL
						deselectRow 0
					else
						openTwitterInMiniBrowser()
				when 1
					if canOpenTweetbot and canOpenTwitter
						Ti.Platform.openURL twitterURL
						deselectRow 0
					else
						if canOpenTweetbot or canOpenTwitter
							openTwitterInMiniBrowser()
						else
							deselectRow 0

				when 2
					if canOpenTweetbot and canOpenTwitter
						openTwitterInMiniBrowser()
					else
						deselectRow 0

				when 3
					deselectRow 0

	self

module.exports = Window