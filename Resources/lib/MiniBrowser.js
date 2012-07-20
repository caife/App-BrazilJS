(function() {
  var MiniBrowser, applyConfig, extend;

  MiniBrowser = (function() {

    function MiniBrowser(dict) {
      var buttonClose, defaults, self;
      defaults = {
        windowTitle: false
      };
      self = this;
      this.actionsDialog = null;
      this.isAndroid = Ti.Platform.osname === "android" ? true : false;
      this.dict = applyConfig(dict, defaults);
      buttonClose = Ti.UI.createButton({
        title: L("close", "Close"),
        style: Ti.UI.iPhone.SystemButtonStyle.DONE
      });
      buttonClose.addEventListener("click", function() {
        return self.windowBrowser.close();
      });
      this.activityIndicator = Ti.UI.createActivityIndicator();
      this.activityIndicator.show();
      this.windowBrowser = Ti.UI.createWindow({
        modal: true,
        backgroundColor: this.dict.backgroundColor,
        barColor: this.dict.barColor,
        leftNavButton: buttonClose,
        rightNavButton: this.activityIndicator
      });
      this.webViewBrowser = Ti.UI.createWebView({
        bottom: this.isAndroid ? 0 : 44,
        loading: false,
        url: this.dict.url
      });
      this.windowBrowser.add(this.webViewBrowser);
      this.createActions();
      this.createToolbar();
      return this.windowBrowser;
    }

    MiniBrowser.prototype.createActions = function() {
      var actionsAct, self;
      self = this;
      this.actionsDialog = Ti.UI.createOptionDialog({
        options: [L("copy_link", "Copy link"), L("open_browser", "Open in Browser"), L("send_by_email", "Send by email"), L("cancel", "Cancel")],
        cancel: 3
      });
      this.actionsDialog.addEventListener("click", function(e) {
        switch (e.index) {
          case 0:
            return Titanium.UI.Clipboard.setText(self.webViewBrowser.url);
          case 1:
            return self.openExternal();
          case 2:
            return self.shareByEmail();
        }
      });
      if (this.isAndroid) {
        actionsAct = this.windowBrowser.activity;
        return actionsAct.onCreateOptionsMenu = function(e) {
          var menu, shareItems;
          menu = e.menu;
          if (self.dict.shareButton) {
            shareItems = menu.add({
              title: "Share"
            });
            return shareItems.addEventListener("click", function() {
              return self.actionsDialog.show();
            });
          }
        };
      }
    };

    MiniBrowser.prototype.createToolbar = function() {
      var buttonAction, buttonBack, buttonForward, buttonRefresh, buttonSpace, buttonStop, self, toolbarButtons;
      self = this;
      buttonAction = Ti.UI.createButton({
        enabled: false,
        systemButton: Ti.UI.iPhone.SystemButton.ACTION
      });
      buttonAction.addEventListener("click", function() {
        return self.actionsDialog.show();
      });
      buttonBack = Ti.UI.createButton({
        image: "/images/icons/Icon-Back.png",
        enabled: false
      });
      buttonBack.addEventListener("click", function() {
        return self.webViewBrowser.goBack();
      });
      buttonForward = Ti.UI.createButton({
        image: "/images/icons/Icon-Forward.png",
        enabled: false
      });
      buttonForward.addEventListener("click", function() {
        return self.webViewBrowser.goForward();
      });
      buttonStop = Ti.UI.createButton({
        systemButton: Ti.UI.iPhone.SystemButton.STOP
      });
      buttonSpace = Ti.UI.createButton({
        systemButton: Ti.UI.iPhone.SystemButton.FLEXIBLE_SPACE
      });
      buttonStop.addEventListener("click", function() {
        self.activityIndicator.hide();
        self.webViewBrowser.stopLoading();
        buttonBack.enabled = self.webViewBrowser.canGoBack();
        buttonForward.enabled = self.webViewBrowser.canGoForward();
        buttonAction.enabled = true;
        self.actionsDialog.title = self.webViewBrowser.url;
        return toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction];
      });
      buttonRefresh = Ti.UI.createButton({
        systemButton: Ti.UI.iPhone.SystemButton.REFRESH
      });
      buttonRefresh.addEventListener("click", function() {
        return self.webViewBrowser.reload();
      });
      toolbarButtons = Ti.UI.iOS.createToolbar({
        barColor: this.dict.barColor,
        bottom: 0,
        height: 44,
        items: [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction]
      });
      this.windowBrowser.add(toolbarButtons);
      this.webViewBrowser.addEventListener("load", function() {
        self.windowBrowser.setRightNavButton(null);
        self.windowBrowser.title = self.webViewBrowser.evalJS("document.title");
        self.actionsDialog.title = self.webViewBrowser.url;
        buttonBack.enabled = self.webViewBrowser.canGoBack();
        buttonForward.enabled = self.webViewBrowser.canGoForward();
        buttonAction.enabled = true;
        return toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction];
      });
      this.webViewBrowser.addEventListener("beforeload", function() {
        self.windowBrowser.setRightNavButton(self.activityIndicator);
        buttonAction.enabled = false;
        return toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonStop, buttonSpace, buttonAction];
      });
      return this.webViewBrowser.addEventListener("error", function() {
        self.windowBrowser.setRightNavButton(null);
        self.actionsDialog.title = self.webViewBrowser.url;
        buttonBack.enabled = webViewBrowser.canGoBack();
        buttonForward.enabled = webViewBrowser.canGoForward();
        buttonAction.enabled = true;
        return toolbarButtons.items = [buttonBack, buttonSpace, buttonForward, buttonSpace, buttonRefresh, buttonSpace, buttonAction];
      });
    };

    MiniBrowser.prototype.openExternal = function() {
      var url;
      url = this.webViewBrowser.url;
      if (this.isAndroid) {
        return Ti.Platform.openURL(url);
      } else {
        if (Ti.Platform.canOpenURL(url)) return Ti.Platform.openURL(url);
      }
    };

    MiniBrowser.prototype.shareByEmail = function() {
      var emailDialog;
      emailDialog = Ti.UI.createEmailDialog({
        barColor: this.windowBrowser.barColor,
        subject: this.windowBrowser.title,
        messageBody: this.webViewBrowser.url
      });
      return emailDialog.open();
    };

    return MiniBrowser;

  })();

  module.exports = MiniBrowser;

  applyConfig = function(object, config) {
    return extend(extend({}, object), config);
  };

  extend = exports.extend = function(object, properties) {
    var key, val;
    for (key in properties) {
      val = properties[key];
      object[key] = val;
    }
    return object;
  };

}).call(this);
