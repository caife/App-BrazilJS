(function() {
  var TabGroup;

  TabGroup = function() {
    var WinLocalization, WinSpeakers, WinTalks, WinTwitter, self, tabLocalization, tabSpeakers, tabTalks, winLocalization, winSpeakers, winTalks;
    WinSpeakers = require("/ui/WinSpeakers");
    WinTalks = require("/ui/WinTalks");
    WinLocalization = require("/ui/WinLocalization");
    WinTwitter = require("/ui/WinTwitter");
    self = Ti.UI.createTabGroup();
    tabTalks = Ti.UI.createTab({
      title: L("talks"),
      icon: "/images/icons/Allotted-Time.png"
    });
    tabSpeakers = Ti.UI.createTab({
      title: L("speakers"),
      icon: "/images/icons/Users.png"
    });
    tabLocalization = Ti.UI.createTab({
      title: L("localization"),
      icon: "/images/icons/Navigation-Map.png"
    });
    winTalks = new WinTalks({
      currenTab: tabTalks
    });
    tabTalks.setWindow(winTalks);
    self.addTab(tabTalks);
    winSpeakers = new WinSpeakers({
      currenTab: tabSpeakers
    });
    tabSpeakers.setWindow(winSpeakers);
    self.addTab(tabSpeakers);
    winLocalization = new WinLocalization({
      currenTab: tabLocalization
    });
    tabLocalization.setWindow(winLocalization);
    self.addTab(tabLocalization);
    return self;
  };

  module.exports = TabGroup;

}).call(this);
