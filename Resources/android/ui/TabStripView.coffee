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
		color: "#FFFFFF"
		font: { fontWeight: "bold", fontSize: "14dp" }

	# Separator View
	if index == 0 or index == 1
		self.add Ti.UI.createView
			height: "45%"
			right: 0
			width: 1
			backgroundColor: "#444444"

	# Footer View
	view = Ti.UI.createView
		width: widthDefault
		height: "6dp"
		bottom: 0
		backgroundColor: "#FFFFFF"
		visible: if selected then true else false
	self.add view

	# Events handler
	self.addEventListener "touchstart", ->
		this.setBackgroundColor "#444444"

	self.addEventListener "touchend", ->
		this.setBackgroundColor "transparent"

	self.addEventListener "touchcancel", ->
		this.setBackgroundColor "transparent"

	# Toggle tab
	self.toggle = (active) ->
		view.visible = active

	self

TabStripView = (dict) ->

	# Initialize values
	tabs = []
	first = true
	index = 0
	selectedIndex = 0

	# View
	self = Ti.UI.createView
		width: Ti.UI.FILL
		height: "50dp"
		top: "44dp"
		layout: "horizontal"
		backgroundColor: "#121212"
	
	# Create Tabs
	for key of dict.tabs
		do (key) ->
		
			# Get values
			d = dict.tabs[key]

			# Create View
			tab = new TabButton(key, d.title, d.icon, index, first)
			self.add tab
			tabs.push tab
			first = false

			# Event handler
			((i,t) ->
				t.addEventListener "click", ->

					self.selectIndex i
					
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