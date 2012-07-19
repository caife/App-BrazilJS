TabGroup = ->

	WinSpeakers = require "/ui/WinSpeakers"
	WinTalks = require "/ui/WinTalks"
	WinLocalization = require "/ui/WinLocalization"
	WinTwitter = require "/ui/WinTwitter"

	# Create TabGroup
	self = Ti.UI.createTabGroup()

	# Tabs
	tabTalks = Ti.UI.createTab
		title: L("talks")
		icon: "/images/icons/Allotted-Time.png"

	tabSpeakers = Ti.UI.createTab
		title: L("speakers")
		icon: "/images/icons/Users.png"

	tabLocalization = Ti.UI.createTab
		title: L("localization")
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
	winLocalization = new WinLocalization
		currenTab: tabLocalization
	tabLocalization.setWindow winLocalization
	self.addTab(tabLocalization)

	self


module.exports = TabGroup