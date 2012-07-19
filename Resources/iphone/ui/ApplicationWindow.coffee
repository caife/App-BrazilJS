TabGroup = ->

	WinSpeakers = require "/ui/WinSpeakers"
	WinTalks = require "/ui/WinTalks"
	WinLocalization = require "/ui/WinLocalization"
	WinTwitter = require "/ui/WinTwitter"

	# Create TabGroup
	self = Ti.UI.createTabGroup()

	# Create Tabs and add to TabGroup

	# Talks
	tabTalks = Ti.UI.createTab
		title: L("talks")
		icon: "/images/icons/Allotted-Time.png"
		window: new WinTalks()
	self.addTab(tabTalks)

	# Speakers
	tabSpeakers = Ti.UI.createTab
		title: L("speakers")
		icon: "/images/icons/Users.png"
		window: new WinSpeakers()
	self.addTab(tabSpeakers)

	# Localization
	tabLocalization = Ti.UI.createTab
		title: L("localization")
		icon: "/images/icons/Navigation-Map.png"
		window: new WinLocalization()
	self.addTab(tabLocalization)

	self


module.exports = TabGroup