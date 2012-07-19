Window = ->

	Model = require "/lib/Model"
	ActionBarView = require "/ui/ActionBarView"
	TabStripView = require "/ui/TabStripView"
	ViewSpeakers = require "/ui/ViewSpeakers"
	ViewTalks = require "/ui/ViewTalks"
	ViewLocalization = require "/ui/ViewLocalization"

	model = new Model()
	config = model.getConfig()

	self = Ti.UI.createWindow
		backgroundColor: "#FFF"
		title: "Home"
		navBarHidden: true
		orientationModes: [Titanium.UI.PORTRAIT]

	# Create ActionBar
	actionBar = new ActionBarView
		title: config.appname
		titleColor: config.theme.android.actionBar.titleColor
		backgroundColor: config.theme.android.actionBar.backgroundColor
		selectedColor: config.theme.android.selectedColor
		buttons:[{
			icon: "/images/New-Email.png"
			id: "share"
			width: 60
		}]

	self.add actionBar

	# Create TabStripView
	tabStripView = new TabStripView
		selectedColor: config.theme.android.selectedColor
		titleColor: config.theme.android.tabStripView.titleColor
		separatorColor: config.theme.android.tabStripView.separatorColor
		borderColor: config.theme.android.tabStripView.borderColor
		backgroundColor: config.theme.android.tabStripView.backgroundColor
		tabs: [
			{ title: L("talks") }
			{ title: L("speakers") }
			{ title: L("localization") }
		]

	self.add tabStripView

	# View Controller
	speakers = new ViewSpeakers()
	talks = new ViewTalks()
	localization = new ViewLocalization()

	viewController = Ti.UI.createScrollableView
		top: "94dp"
		left: 0
		right: 0
		bottom: 0
		views: [talks, speakers, localization]
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