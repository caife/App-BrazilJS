Window = ->

	ActionBarView = require "/ui/ActionBarView"
	TabStripView = require "/ui/TabStripView"
	ViewSpeakers = require "/ui/ViewSpeakers"
	ViewTalks = require "/ui/ViewTalks"
	ViewLocalization = require "/ui/ViewLocalization"

	self = Ti.UI.createWindow
		backgroundColor: "#FFF"
		title: "Home"
		navBarHidden: true
		orientationModes: [Titanium.UI.PORTRAIT]

	# Create ActionBar
	actionBar = new ActionBarView
		title: "BrazilJS"
		buttons:[{
			icon: "/images/icons/Closed-Mail.png"
			id: "share"
			width: 60
		}]

	self.add actionBar

	# Create TabStripView
	tabStripView = new TabStripView
		tabs:
			talks:
				title: L("talks")
				icon: "/images/icons/Allotted-Time.png"

			speakers:
				title: L("speakers")
				icon: "/images/icons/Users.png"

			localization:
				title: L("localization")
				icon: "/images/icons/Navigation-Map.png"

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