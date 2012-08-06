Window = ->

	Model = require "/lib/Model"
	ActionBarView = require "/lib/ActionBarView"
	TabStripView = require "/lib/TabStripView"
	ViewSpeakers = require "/ui/ViewSpeakers"
	ViewTalks = require "/ui/ViewTalks"
	ViewLocation = require "/ui/ViewLocation"

	model = new Model()
	config = model.getConfig()

	# Register for Push Notification, if needed
	if config.push_notification.enabled == true

		Notification = require "/lib/Notification"
		notification = new Notification
			id: config.push_notification.android.id
			register_url: config.push_notification.android.register_url

		notification.registerForPushNotification()

	self = Ti.UI.createWindow
		exitOnClose: true
		backgroundColor: "#FFF"
		navBarHidden: true
		orientationModes: [Titanium.UI.PORTRAIT]

	# Create ActionBar
	actionBar = new ActionBarView
		title: config.appname
		titleColor: config.theme.android.actionBar.titleColor
		backgroundColor: config.theme.android.actionBar.backgroundColor
		backgroundImage: config.theme.android.actionBar.backgroundImage
		selectedColor: config.theme.android.selectedBackgroundColor
		buttons:[{
			icon: "/images/New-Email.png"
			id: "contact"
			width: 60
		}]

	self.add actionBar

	# Create TabStripView
	tabStripView = new TabStripView
		selectedColor: config.theme.android.selectedBackgroundColor
		titleColor: config.theme.android.tabStripView.titleColor
		separatorColor: config.theme.android.tabStripView.separatorColor
		borderColor: config.theme.android.tabStripView.borderColor
		backgroundColor: config.theme.android.tabStripView.backgroundColor
		tabs: [
			{ title: L("talks") }
			{ title: L("location") }
			{ title: L("speakers") }
		]

	self.add tabStripView

	# View Controller
	speakers = new ViewSpeakers()
	talks = new ViewTalks(self)
	location = new ViewLocation()

	viewController = Ti.UI.createScrollableView
		top: "94dp"
		left: 0
		right: 0
		bottom: 0
		views: [talks, location, speakers]
		showPagingControl: false
		backgroundColor: "#000"

	self.add viewController

	# ProgressView
	progressView = Ti.UI.createActivityIndicator
		messageid: "loading"
	self.add progressView

	setTimeout ->
		progressView.show()
	, 100

	# Events handler
	viewController.addEventListener "scroll", (e) ->
		tabStripView.selectIndex e.currentPage

	tabStripView.addEventListener "selected", (e) ->
		viewController.scrollToView e.index

	actionBar.addEventListener "buttonPress", (e) ->
		if e.id == "contact"
			Ti.Platform.openURL "mailto:#{config.mail_contact}"

	self.addEventListener "showProgressView", ->
		progressView.show()

	self.addEventListener "hideProgressView", ->
		progressView.hide()

	# Android Fisical Menu
	activity = self.activity

	activity.onCreateOptionsMenu = (e) ->
		menu = e.menu;

		refreshTitle = L("refresh")
		refresh = menu.add
			title: refreshTitle
			itemId: 0

		refresh.addEventListener "click", (e) ->
			talks.fireEvent("refreshList")

	activity.onPrepareOptionsMenu = (e) ->
		menu = e.menu

		if viewController.currentPage == 0
			menu.findItem(0).setVisible true
		else
			menu.findItem(0).setVisible false

	self

module.exports = Window