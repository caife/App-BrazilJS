class TabStripView

	constructor: (dict) ->

		self = @
		@dict = dict
		@tabWidth = Ti.Platform.displayCaps.platformWidth / @dict.tabs.length
		@tabs = []
		@index = 0
		@selectedIndex = 0
		
		# Create the View
		@tabStripView = Ti.UI.createView
			height: "50dp"
			top: "44dp"

		# Footer View
		footerView = Ti.UI.createView
			width: Ti.UI.FILL
			height: "2dp"
			bottom: 0
			backgroundColor: @dict.borderColor
		@tabStripView.add footerView

		# View
		tabsView = Ti.UI.createView
			width: Ti.UI.FILL
			height: "49dp"
			layout: "horizontal"
			backgroundColor: @dict.backgroundColor
		@tabStripView.add tabsView

		# Create Tabs
		for tab in dict.tabs
			do (tab) ->

				tabView = self.createTabButton tab
				self.tabs.push tabView

				tabsView.add tabView
			
		# Event handler (click)
		@tabStripView.selectIndex = (index) ->

			for tab in self.tabs
				do (tab) ->
					if (tab.index == index)
						tab.toggle(true)
					else
						tab.toggle(false)

		# Return View
		return @tabStripView

	# Create a TabButton
	createTabButton: (d) ->

		self = @

		# View
		tab = Ti.UI.createView
			width: @tabWidth
			backgroundColor: "transparent"
			index: @index
			selected: if @index == 0 then true else false

		backgroundSelected = Ti.UI.createView
			width: Ti.UI.FILL
			height: Ti.UI.FILL
			backgroundColor: "transparent"
		tab.add backgroundSelected

		# Title Label
		tab.add Ti.UI.createLabel
			text: d.title
			color: @dict.titleColor
			font: { fontWeight: "bold", fontSize: "14dp" }

		# Separator View
		if @index == 0 or @index == 1
			tab.add Ti.UI.createView
				height: "45%"
				right: 0
				width: 1
				backgroundColor: @dict.separatorColor

		# Active View
		activeView = Ti.UI.createView
			width: @tabWidth
			height: "6dp"
			bottom: 0
			backgroundColor: @dict.borderColor
			visible: if @index == 0 then true else false
		tab.add activeView

		# Events handler
		tab.addEventListener "touchstart", ->
			backgroundSelected.setOpacity 0.9
			backgroundSelected.setBackgroundColor self.dict.selectedColor

		tab.addEventListener "touchend", ->
			backgroundSelected.setBackgroundColor "transparent"

		tab.addEventListener "touchcancel", ->
			backgroundSelected.setBackgroundColor "transparent"

		# Toggle tab
		tab.toggle = (active) ->
			activeView.visible = active

		# Event handler
		((i,t) ->
			t.addEventListener "click", ->

				self.tabStripView.fireEvent "selected",
					index: i

		)(@index, tab)

		@index++

		tab

module.exports = TabStripView