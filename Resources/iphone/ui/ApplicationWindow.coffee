TabGroup = ->

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