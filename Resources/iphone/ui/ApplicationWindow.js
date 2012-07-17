(function() {
  var TabGroup;

  TabGroup = function() {
    var WinSpeakers, self, tabLocalization, tabSpeakers, tabTalks, tabTwitter;
    WinSpeakers = require("/ui/WinSpeakers");
    self = Ti.UI.createTabGroup();
    tabTalks = Ti.UI.createTab({
      title: L("talks"),
      icon: "/images/icons/Allotted-Time.png"
    });
    self.addTab(tabTalks);
    tabSpeakers = Ti.UI.createTab({
      title: L("speakers"),
      icon: "/images/icons/Users.png",
      window: new WinSpeakers()
    });
    self.addTab(tabSpeakers);
    tabLocalization = Ti.UI.createTab({
      title: L("localization"),
      icon: "/images/icons/Navigation-Map.png"
    });
    self.addTab(tabLocalization);
    tabTwitter = Ti.UI.createTab({
      title: L("twitter"),
      icon: "/images/icons/Twitter-New.png"
    });
    self.addTab(tabTwitter);
    return self;
  };

  module.exports = TabGroup;

}).call(this);
