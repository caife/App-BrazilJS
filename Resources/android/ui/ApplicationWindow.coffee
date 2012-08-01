Window = ->

	Model = require "/lib/Model"
	ActionBarView = require "/ui/ActionBarView"
	TabStripView = require "/ui/TabStripView"
	ViewSpeakers = require "/ui/ViewSpeakers"
	ViewTalks = require "/ui/ViewTalks"
	ViewLocation = require "/ui/ViewLocation"

	model = new Model()
	config = model.getConfig()

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
			id: "share"
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
			{ title: L("speakers") }
			{ title: L("location") }
		]

	self.add tabStripView

	# View Controller
	speakers = new ViewSpeakers()
	talks = new ViewTalks()
	location = new ViewLocation()

	viewController = Ti.UI.createScrollableView
		top: "94dp"
		left: 0
		right: 0
		bottom: 0
		views: [talks, speakers, location]
		showPagingControl: false
		backgroundColor: "#000"

	self.add viewController

	# Events handler
	viewController.addEventListener "scroll", (e) ->
		tabStripView.selectIndex e.currentPage

	tabStripView.addEventListener "selected", (e) ->
		viewController.scrollToView e.index

	self

module.exports = Window