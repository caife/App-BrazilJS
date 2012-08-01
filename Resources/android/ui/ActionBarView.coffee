class ActionBarView

	constructor: (dict) ->

		self = @
		@dict = dict
		@buttonOffset = 0

		# Create the View
		@actionBarView = Ti.UI.createView
			height: "44dp"
			top: 0
			backgroundColor: @dict.backgroundColor
			backgroundImage: @dict.backgroundImage

		# Application Icon
		applicationIcon = Ti.UI.createImageView
			image: "/images/ui/Icon.png"
			left: "20dp"
			top: "6dp"
			bottom: "6dp"
			width: "32dp"
			borderRadius: 4
		@actionBarView.add applicationIcon

		# Create BackButton
		if typeof @dict.backButton != "undefined"
			if @dict.backButton == true

				# Create BackImage
				backImageView = Ti.UI.createImageView
					backgroundImage: "/images/Navigation-Back.png"
					left: "6dp"
					width: "10dp"
					height: "32dp"
				@actionBarView.add backImageView

				# Create BackButton
				backgroundBackButton = Ti.UI.createButton
					zIndex: -10
					width: "56dp"
					left: 0
					top: 0
					bottom: 0
					opacity: 0.8
					backgroundColor: "transparent"
				@actionBarView.add backgroundBackButton

				# Create BackButton
				backButton = Ti.UI.createButton
					width: "52dp"
					left: 0
					top: 0
					bottom: 0
					backgroundColor: "transparent"
				@actionBarView.add backButton

				# Event handler
				backButton.addEventListener "click", ->
					self.actionBarView.fireEvent "back"

				backButton.addEventListener "touchstart", ->
					backgroundBackButton.setBackgroundColor self.dict.selectedColor

				backButton.addEventListener "touchend", ->
					backgroundBackButton.setBackgroundColor "transparent"

				backButton.addEventListener "touchcancel", ->
					backgroundBackButton.setBackgroundColor "transparent"

		# If have title, show a label. If have not, show an image.
		if typeof @dict.title != "undefined"
			@actionBarView.add Ti.UI.createLabel
				text: @dict.title
				left: "60dp"
				color: @dict.titleColor
				font:
					fontSize: "18dp"
					fontWeight: "bold"

		# Create buttons
		if typeof @dict.buttons != "undefined"
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