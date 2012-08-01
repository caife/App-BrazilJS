TabGroup = ->

	# Get config file
	Model = require "/lib/Model"
	model = new Model()
	config = model.getConfig()

	if config.push_notification == true

		# Register for Push Notification
		Ti.Network.registerForPushNotifications
			types: [
				Ti.Network.NOTIFICATION_TYPE_ALERT
				Ti.Network.NOTIFICATION_TYPE_SOUND
			]
			success: (e) ->
				# Get Device Token and send it to WS
				deviceToken = e.deviceToken

				if !Ti.App.Properties.hasProperty "push_registered"

					xhr = Ti.Network.createHTTPClient
						onload: ->
							Ti.App.Properties.setBool "push_registered", true

					xhr.open "POST", "#{config.ws.registerForPush}/#{deviceToken}"
					xhr.send()

			callback: (e) ->
				# Show alert to user with message
				Ti.UI.createAlertDialog
					title: config.appname
					message: e.data.alert
				.show()

				Ti.UI.iPhone.setAppBadge 0

			error: (e) ->
				alert e.error

	WinSpeakers = require "/ui/WinSpeakers"
	WinTalks = require "/ui/WinTalks"
	WinLocation = require "/ui/WinLocation"

	# Create TabGroup
	self = Ti.UI.createTabGroup()

	# Tabs
	tabTalks = Ti.UI.createTab
		title: L("talks")
		icon: "/images/icons/Allotted-Time.png"

	tabSpeakers = Ti.UI.createTab
		title: L("speakers")
		icon: "/images/icons/Users.png"

	tabLocation = Ti.UI.createTab
		title: L("location")
		icon: "/images/icons/Navigation-Map.png"

	# Talks
	winTalks = new WinTalks
		currenTab: tabTalks
	tabTalks.setWindow winTalks
	self.addTab(tabTalks)

	# Speakers
	winSpeakers = new WinSpeakers
		currenTab: tabSpeakers
	tabSpeakers.setWindow winSpeakers
	self.addTab(tabSpeakers)

	# Localization
	winLocation = new WinLocation
		currenTab: tabLocation
	tabLocation.setWindow winLocation
	self.addTab(tabLocation)

	self


module.exports = TabGroup