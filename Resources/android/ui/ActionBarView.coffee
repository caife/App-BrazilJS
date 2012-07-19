class ActionBarView

	constructor: (dict) ->

		@dict = dict
		@buttonOffset = 0

		# Create the View
		@actionBarView = Ti.UI.createView
			height: "44dp"
			top: 0
			backgroundColor: @dict.backgroundColor

		# If have title, show a label. If have not, show an image.
		if typeof @dict.title != "undefined"
			@actionBarView.add Ti.UI.createLabel
				text: @dict.title
				left: "5dp"
				color: @dict.titleColor
				font:
					fontSize: "18dp"
					fontWeight: "bold"
		else
			@actionBarView.add Ti.UI.createImageView
				image: @dict.icon
				left: "5dp"

		# Create buttons
		@createActionBarButton button for button in @dict.buttons

		return @actionBarView

	# Methods
	createActionBarButton: (b) ->

		self = @

		# Create button
		button = Ti.UI.createView
			width: "#{b.width}dp"
			right: "#{@buttonOffset}dp"

		# Label or Icon
		if b.title

			buttonLabel = Ti.UI.createLabel
				text: b.title
				color: @dict.titleColor
				height: Ti.UI.SIZE
				width: Ti.UI.SIZE
				textAlign: "center"
				font:
					fontSize: "14dp"
					fontWeight: "bold"

			button.add(buttonLabel);

		else if b.icon

			buttonIcon = Ti.UI.createImageView
				image: b.icon
				height: "32dp"
				width: "32dp"

			button.add(buttonIcon);

		# Add button to View
		@actionBarView.add button

		# A little hack to border left
		@actionBarView.add Ti.UI.createView
			backgroundColor: "#DEDEDE"
			width: 1
			height: Ti.UI.FILL
			right: @buttonOffset + b.width + 1 + "dp"

		# Event handler
		button.addEventListener "click", ->
			self.actionBarView.fireEvent "buttonPress",
				id: b.id

		button.addEventListener "touchstart", ->
			this.setBackgroundColor self.dict.selectedColor

		button.addEventListener "touchend", ->
			this.setBackgroundColor "transparent"

		button.addEventListener "touchcancel", ->
			this.setBackgroundColor "transparent"

		@buttonOffset += (b.width + 7)


module.exports = ActionBarView