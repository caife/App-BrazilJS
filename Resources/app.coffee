# Bootstrap application (set file data in Properties)
Bootstrap = require "/lib/Bootstrap"
Bootstrap.setInitialConfigutarion()

# Open ApplicationWindow
ApplicationWindow = require "/ui/ApplicationWindow"
new ApplicationWindow().open()

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