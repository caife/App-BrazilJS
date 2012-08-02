class Notification

	constructor: (dict) ->
		@id = dict.id
		@register_url = dict.register_url


	registerForPushNotification: ->

		gcm = require "com.activate.gcm"

		self = @

		gcm.registerC2dm @id,
			success: (e) ->

				device_id = e.registrationId

				xhr = Ti.Network.createHTTPClient
					onload: ->
						return
					onerror: (e) ->
						alert e.error

				xhr.open "POST", "#{self.register_url}/#{device_id}"
				xhr.send()

			error: (e) ->

				alert "Error during registration : #{e.error}"

				if e.error == "ACCOUNT_MISSING"
					message = "No Google account found; you will need to add on in order to activate notifications"

				Ti.UI.createAlertDialog
					title: "Push Notification Setup"
					message: message
					buttonNames: ["OK"]
				.show()

			callback: (e) ->

				# Show AlertDialog
				Ti.UI.createAlertDialog
					title: e.data.title
					message: e.data.message
					buttonNames: ["OK"]
				.show()

				intent = Ti.Android.createIntent
					action: Ti.Android.ACTION_MAIN
					flags: Ti.Android.FLAG_ACTIVITY_SINGLE_TOP
					packageName: "com.rafaelks.braziljs"
					className: "org.appcelerator.titanium.TiActivity"
				intent.addCategory Ti.Android.CATEGORY_LAUNCHER

				pending = Ti.Android.createPendingIntent
					activity: Ti.Android.currentActivity
					intent: intent
					type: Ti.Android.PENDING_INTENT_FOR_ACTIVITY
					flags: Ti.Android.FLAG_UPDATE_CURRENT | Ti.Android.FLAG_NO_CLEAR

				notification = Ti.Android.createNotification
					icon: Ti.App.Android.R.drawable.ic_stat
					contentIntent: pending
					contentTitle: e.data.title
					contentText: e.data.message
					tickerText: e.data.title

				Ti.Android.NotificationManager.notify 1, notification

module.exports = Notification