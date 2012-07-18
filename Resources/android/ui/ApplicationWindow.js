(function() {
  var Window;

  Window = function() {
    var ActionBarView, TabStripView, ViewLocalization, ViewSpeakers, ViewTalks, actionBar, localization, self, speakers, tabStripView, talks, viewController;
    ActionBarView = require("/ui/ActionBarView");
    TabStripView = require("/ui/TabStripView");
    ViewSpeakers = require("/ui/ViewSpeakers");
    ViewTalks = require("/ui/ViewTalks");
    ViewLocalization = require("/ui/ViewLocalization");
    self = Ti.UI.createWindow({
      backgroundColor: "#FFF",
      title: "Home",
      navBarHidden: true,
      orientationModes: [Titanium.UI.PORTRAIT]
    });
    actionBar = new ActionBarView({
      title: "BrazilJS",
      buttons: [
        {
          icon: "/images/icons/Closed-Mail.png",
          id: "share",
          width: 60
        }
      ]
    });
    self.add(actionBar);
    tabStripView = new TabStripView({
      tabs: {
        talks: {
          title: L("talks"),
          icon: "/images/icons/Allotted-Time.png"
        },
        speakers: {
          title: L("speakers"),
          icon: "/images/icons/Users.png"
        },
        localization: {
          title: L("localization"),
          icon: "/images/icons/Navigation-Map.png"
        },
        twitter: {
          title: L("twitter"),
          icon: "/images/icons/Twitter-New.png"
        }
      }
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
