(function() {
  var Window;

  Window = function() {
    var ActionBarView, Model, TabStripView, ViewLocalization, ViewSpeakers, ViewTalks, actionBar, config, localization, model, self, speakers, tabStripView, talks, viewController;
    Model = require("/lib/Model");
    ActionBarView = require("/ui/ActionBarView");
    TabStripView = require("/ui/TabStripView");
    ViewSpeakers = require("/ui/ViewSpeakers");
    ViewTalks = require("/ui/ViewTalks");
    ViewLocalization = require("/ui/ViewLocalization");
    model = new Model();
    config = model.getConfig();
    self = Ti.UI.createWindow({
      backgroundColor: "#FFF",
      navBarHidden: true,
      orientationModes: [Titanium.UI.PORTRAIT]
    });
    actionBar = new ActionBarView({
      title: config.appname,
      titleColor: config.theme.android.actionBar.titleColor,
      backgroundColor: config.theme.android.actionBar.backgroundColor,
      selectedColor: config.theme.android.selectedColor,
      buttons: [
        {
          icon: "/images/New-Email.png",
          id: "share",
          width: 60
        }
      ]
    });
    self.add(actionBar);
    tabStripView = new TabStripView({
      selectedColor: config.theme.android.selectedColor,
      titleColor: config.theme.android.tabStripView.titleColor,
      separatorColor: config.theme.android.tabStripView.separatorColor,
      borderColor: config.theme.android.tabStripView.borderColor,
      backgroundColor: config.theme.android.tabStripView.backgroundColor,
      tabs: [
        {
          title: L("talks")
        }, {
          title: L("speakers")
        }, {
          title: L("localization")
        }
      ]
    });
    self.add(tabStripView);
    speakers = new ViewSpeakers();
    talks = new ViewTalks();
    localization = new ViewLocalization();
    viewController = Ti.UI.createScrollableView({
      top: "94dp",
      left: 0,
      right: 0,
      bottom: 0,
      views: [talks, speakers, localization],
      showPagingControl: false,
      backgroundColor: "#000"
    });
    self.add(viewController);
    viewController.addEventListener("scroll", function(e) {
      return tabStripView.selectIndex(e.currentPage);
    });
    tabStripView.addEventListener("selected", function(e) {
      return viewController.scrollToView(e.index);
    });
    return self;
  };

  module.exports = Window;

}).call(this);
