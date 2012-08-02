class MiniBrowser

	constructor: (dict) ->

		# Prepare parameters
		defaults = {}

		self = @
		@actionsDialog = null
		@isAndroid = if Ti.Platform.osname == "android" then true else false
		@dict = applyConfig dict, defaults

		# Button to Close
		buttonClose = Ti.UI.createButton
			title: L("close", "Close")
			style: Ti.UI.iPhone.SystemButtonStyle.DONE

		# Event Handler
		buttonClose.addEventListener "click", ->
			self.windowBrowser.close()

		# Create ActivityIndicator
		@activityIndicator = Ti.UI.createActivityIndicator()
		@activityIndicator.show()

		# Create Window
		@windowBrowser = Ti.UI.createWindow
			modal: true
			backgroundColor: @dict.backgroundColor
			barColor: @dict.barColor
			leftNavButton: buttonClose
			rightNavButton: @activityIndicator

		# Create the WebView
		@webViewBrowser = Ti.UI.createWebView
			bottom: if @isAndroid then 0 else 44
			loading: false
			url: @dict.url
		@windowBrowser.add @webViewBrowser

		# Create ActionDialog and Android fisical menu structure
		@createActions()

		# Create Toolbar and set it to Window
		@createToolbar()

		return @windowBrowser

	createActions: ->

		self = @

		# Create ActionDialog
		@actionsDialog = Ti.UI.createOptionDialog
			options: [
				L("copy_link", "Copy link")
				L("open_browser", "Open in Browser")
				L("send_by_email", "Send by email")
				L("cancel", "Cancel")
			]
			cancel : 3

		# Event handler
		@actionsDialog.addEventListener "click", (e) ->
			switch e.index
				when 0 then Titanium.UI.Clipboard.setText self.webViewBrowser.url
				when 1 then self.openExternal()
				when 2 then self.shareByEmail()

		# Create fisical menu in Android
		if @isAndroid

			actionsAct = @windowBrowser.activity

			actionsAct.onCreateOptionsMenu = (e) ->
				menu = e.menu;
			
				if self.dict.shareButton

					shareItems = menu.add
						title: "Share"

					shareItems.addEventListener "click", ->
						self.actionsDialog.show()

	createToolbar: ->

		self = @

		buttonAction = Ti.UI.createButton
			enabled: false
			systemButton: Ti.UI.iPhone.SystemButton.ACTION
		
		buttonAction.addEventListener "click", ->
			self.actionsDialog.show()

		buttonBack = Ti.UI.createButton
			image: "/images/icons/Icon-Back.png"
			enabled: false

		buttonBack.addEventListener "click", ->
			self.webViewBrowser.goBack()

		buttonForward = Ti.UI.createButton
			image: "/images/icons/Icon-Forward.png"
			enabled: false

		buttonForward.addEventListener "click", ->
			self.webViewBrowser.goForward()

		buttonStop = Ti.UI.createButton
			systemButton: Ti.UI.iPhone.SystemButton.STOP

		buttonSpace = Ti.UI.createButton
			systemButton: Ti.UI.iPhone.SystemButton.FLEXIBLE_SPACE

		buttonStop.addEventListener "click", ->

			# Stop ActivityIndicator
			self.activityIndicator.hide()

			# Stop WebView
			self.webViewBrowser.stopLoading()
			
			# Change "enabled" of some buttons
			buttonBack.enabled = self.webViewBrowser.canGoBack()
			buttonForward.enabled = self.webViewBrowser.canGoForward()
			buttonAction.enabled = true
			
			# Change title of ActionsDialog
			self.actionsDialog.title = self.webViewBrowser.url

			# Set items to Toolbar
			toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction]

		buttonRefresh = Ti.UI.createButton
			systemButton: Ti.UI.iPhone.SystemButton.REFRESH

		buttonRefresh.addEventListener "click", ->
			self.webViewBrowser.reload()

		# Create ToolbarView
		toolbarButtons = Ti.UI.iOS.createToolbar
			barColor: @dict.barColor
			bottom: 0,
			height: 44
			items: [
				buttonBack
				buttonSpace
				buttonForward
				buttonSpace
				buttonRefresh
				buttonSpace
				buttonAction
			]
		@windowBrowser.add toolbarButtons

		@webViewBrowser.addEventListener "load", ->

			# Remove ActivityIndicator
			self.windowBrowser.setRightNavButton null
		
			# Update titles
			self.windowBrowser.title = self.webViewBrowser.evalJS "document.title"
			self.actionsDialog.title = self.webViewBrowser.url

			# Update Toolbar Buttons
			buttonBack.enabled = self.webViewBrowser.canGoBack()
			buttonForward.enabled = self.webViewBrowser.canGoForward()
			buttonAction.enabled = true
			toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction]

		@webViewBrowser.addEventListener "beforeload", ->

			# Turn Activity Indicator active
			self.windowBrowser.setRightNavButton self.activityIndicator

			# Update Toolbar Buttons
			buttonAction.enabled = false
			toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonStop, buttonSpace, buttonAction]

		@webViewBrowser.addEventListener "error", ->

			# Remove ActivityIndicator
			self.windowBrowser.setRightNavButton null

			# Update Title of ActionsDialog
			self.actionsDialog.title = self.webViewBrowser.url

			# Update Toolbar Buttons
			buttonBack.enabled = webViewBrowser.canGoBack()
			buttonForward.enabled = webViewBrowser.canGoForward()
			buttonAction.enabled = true
			toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction]


	# Aciton to open link in another Browser
	openExternal: ->

		url = @webViewBrowser.url

		if @isAndroid
			Ti.Platform.openURL url
		else
			if Ti.Platform.canOpenURL url
				Ti.Platform.openURL url

	# Action to Share by Email
	shareByEmail: ->

		emailDialog = Ti.UI.createEmailDialog
			barColor: @windowBrowser.barColor
			subject: @windowBrowser.title
			messageBody: @webViewBrowser.url

		emailDialog.open()

module.exports = MiniBrowser

# CoffeeScript extends
applyConfig = (object, config) ->
	extend (extend {}, object), config

extend = exports.extend = (object, properties) ->
	for key, val of properties
		object[key] = val
	object