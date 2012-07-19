(function() {
  var TabGroup;

  TabGroup = function() {
    var WinLocalization, WinSpeakers, WinTalks, WinTwitter, self, tabLocalization, tabSpeakers, tabTalks;
    WinSpeakers = require("/ui/WinSpeakers");
    WinTalks = require("/ui/WinTalks");
    WinLocalization = require("/ui/WinLocalization");
    WinTwitter = require("/ui/WinTwitter");
    self = Ti.UI.createTabGroup();
    tabTalks = Ti.UI.createTab({
      title: L("talks"),
      icon: "/images/icons/Allotted-Time.png",
      window: new WinTalks()
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
      icon: "/images/icons/Navigation-Map.png",
      window: new WinLocalization()
    });
    self.addTab(tabLocalization);
    return self;
  };

  module.exports = TabGroup;

}).call(this);
