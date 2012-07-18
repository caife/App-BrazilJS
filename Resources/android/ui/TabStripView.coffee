# Get width of individual tab
tabWidth = ->
	Ti.Platform.displayCaps.platformWidth / 3

# Create a single TabButton
TabButton = (id, text, icon, index, selected) ->

	widthDefault = tabWidth()

	# View
	self = Ti.UI.createView
		width: widthDefault
		opacity: 1.0
		backgroundColor: "transparent"
		id: id
		index: index
		selected: selected

	# Title Label
	self.add Ti.UI.createLabel
		text: text
		color: "#222222"
		font: { fontWeight: "bold", fontSize: "14dp" }

	# Separator View
	if index == 0 or index == 1
		self.add Ti.UI.createView
			height: "45%"
			right: 0
			width: 1
			backgroundColor: "#222222"

	# Active View
	activeView = Ti.UI.createView
		width: widthDefault
		height: "4dp"
		bottom: 0
		backgroundColor: "#222222"
		visible: if selected then true else false
	self.add activeView

	# Events handler
	self.addEventListener "touchstart", ->
		this.setBackgroundColor "#DDDDDD"

	self.addEventListener "touchend", ->
		this.setBackgroundColor "transparent"

	self.addEventListener "touchcancel", ->
		this.setBackgroundColor "transparent"

	# Toggle tab
	self.toggle = (active) ->
		activeView.visible = active

	self

TabStripView = (dict) ->

	# Initialize values
	tabs = []
	first = true
	index = 0
	selectedIndex = 0

	self = Ti.UI.createView
		height: "50dp"
		top: "44dp"

	# Footer View
	footerView = Ti.UI.createView
		width: Ti.UI.FILL
		height: "2dp"
		bottom: 0
		backgroundColor: "#222222"
	self.add footerView

	# View
	tabsView = Ti.UI.createView
		width: Ti.UI.FILL
		height: "49dp"
		layout: "horizontal"
		backgroundColor: "#DDDDDD"
	self.add tabsView
	
	# Create Tabs
	for key of dict.tabs
		do (key) ->
		
			# Get values
			d = dict.tabs[key]

			# Create View
			tab = new TabButton(key, d.title, d.icon, index, first)
			tabsView.add tab
			tabs.push tab
			first = false

			# Event handler
			((i,t) ->
				t.addEventListener "click", ->

					self.fireEvent "selected",
						index: i

			)(index, tab)

			index++

	# Event handler (click)
	self.selectIndex = (index) ->

		toggleTab = (tab) ->

			if (tab.index == index)
				tab.toggle(true)
			else
				tab.toggle(false)

		toggleTab tab for tab in tabs

	# Return View
	self

module.exports = TabStripView;