(function() {
  var TabButton, TabStripView, tabWidth;

  tabWidth = function() {
    return Ti.Platform.displayCaps.platformWidth / 3;
  };

  TabButton = function(id, text, icon, index, selected) {
    var self, view, widthDefault;
    widthDefault = tabWidth();
    self = Ti.UI.createView({
      width: widthDefault,
      opacity: 1.0,
      backgroundColor: "transparent",
      id: id,
      index: index,
      selected: selected
    });
    self.add(Ti.UI.createLabel({
      text: text,
      color: "#FFFFFF",
      font: {
        fontWeight: "bold",
        fontSize: "14dp"
      }
    }));
    if (index === 0 || index === 1) {
      self.add(Ti.UI.createView({
        height: "45%",
        right: 0,
        width: 1,
        backgroundColor: "#444444"
      }));
    }
    view = Ti.UI.createView({
      width: widthDefault,
      height: "6dp",
      bottom: 0,
      backgroundColor: "#FFFFFF",
      visible: selected ? true : false
    });
    self.add(view);
    self.addEventListener("touchstart", function() {
      return this.setBackgroundColor("#444444");
    });
    self.addEventListener("touchend", function() {
      return this.setBackgroundColor("transparent");
    });
    self.addEventListener("touchcancel", function() {
      return this.setBackgroundColor("transparent");
    });
    self.toggle = function(active) {
      return view.visible = active;
    };
    return self;
  };

  TabStripView = function(dict) {
    var first, index, key, selectedIndex, self, tabs, _fn;
    tabs = [];
    first = true;
    index = 0;
    selectedIndex = 0;
    self = Ti.UI.createView({
      width: Ti.UI.FILL,
      height: "50dp",
      top: "44dp",
      layout: "horizontal",
      backgroundColor: "#121212"
    });
    _fn = function(key) {
      var d, tab;
      d = dict.tabs[key];
      tab = new TabButton(key, d.title, d.icon, index, first);
      self.add(tab);
      tabs.push(tab);
      first = false;
      (function(i, t) {
        return t.addEventListener("click", function() {
          self.selectIndex(i);
          return self.fireEvent("selected", {
            index: i
          });
        });
      })(index, tab);
      return index++;
    };
    for (key in dict.tabs) {
      _fn(key);
    }
    self.selectIndex = function(index) {
      var tab, toggleTab, _i, _len, _results;
      toggleTab = function(tab) {
        if (tab.index === index) {
          return tab.toggle(true);
        } else {
          return tab.toggle(false);
        }
      };
      _results = [];
      for (_i = 0, _len = tabs.length; _i < _len; _i++) {
        tab = tabs[_i];
        _results.push(toggleTab(tab));
      }
      return _results;
    };
    return self;
  };

  module.exports = TabStripView;

}).call(this);
