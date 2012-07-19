(function() {
  var TabStripView;

  TabStripView = (function() {

    function TabStripView(dict) {
      var footerView, self, tab, tabsView, _fn, _i, _len, _ref;
      self = this;
      this.dict = dict;
      this.tabWidth = Ti.Platform.displayCaps.platformWidth / this.dict.tabs.length;
      this.tabs = [];
      this.index = 0;
      this.selectedIndex = 0;
      this.tabStripView = Ti.UI.createView({
        height: "50dp",
        top: "44dp"
      });
      footerView = Ti.UI.createView({
        width: Ti.UI.FILL,
        height: "2dp",
        bottom: 0,
        backgroundColor: this.dict.borderColor
      });
      this.tabStripView.add(footerView);
      tabsView = Ti.UI.createView({
        width: Ti.UI.FILL,
        height: "49dp",
        layout: "horizontal",
        backgroundColor: this.dict.backgroundColor
      });
      this.tabStripView.add(tabsView);
      _ref = dict.tabs;
      _fn = function(tab) {
        var tabView;
        tabView = self.createTabButton(tab);
        self.tabs.push(tabView);
        return tabsView.add(tabView);
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tab = _ref[_i];
        _fn(tab);
      }
      this.tabStripView.selectIndex = function(index) {
        var tab, _j, _len2, _ref2, _results;
        _ref2 = self.tabs;
        _results = [];
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          tab = _ref2[_j];
          _results.push((function(tab) {
            if (tab.index === index) {
              return tab.toggle(true);
            } else {
              return tab.toggle(false);
            }
          })(tab));
        }
        return _results;
      };
      return this.tabStripView;
    }

    TabStripView.prototype.createTabButton = function(d) {
      var activeView, self, tab;
      self = this;
      tab = Ti.UI.createView({
        width: this.tabWidth,
        backgroundColor: "transparent",
        index: this.index,
        selected: this.index === 0 ? true : false
      });
      tab.add(Ti.UI.createLabel({
        text: d.title,
        color: this.dict.titleColor,
        font: {
          fontWeight: "bold",
          fontSize: "14dp"
        }
      }));
      if (this.index === 0 || this.index === 1) {
        tab.add(Ti.UI.createView({
          height: "45%",
          right: 0,
          width: 1,
          backgroundColor: this.dict.separatorColor
        }));
      }
      activeView = Ti.UI.createView({
        width: this.tabWidth,
        height: "4dp",
        bottom: 0,
        backgroundColor: this.dict.borderColor,
        visible: this.index === 0 ? true : false
      });
      tab.add(activeView);
      tab.addEventListener("touchstart", function() {
        return this.setBackgroundColor(self.dict.selectedColor);
      });
      tab.addEventListener("touchend", function() {
        return this.setBackgroundColor("transparent");
      });
      tab.addEventListener("touchcancel", function() {
        return this.setBackgroundColor("transparent");
      });
      tab.toggle = function(active) {
        return activeView.visible = active;
      };
      (function(i, t) {
        return t.addEventListener("click", function() {
          return self.tabStripView.fireEvent("selected", {
            index: i
          });
        });
      })(this.index, tab);
      this.index++;
      return tab;
    };

    return TabStripView;

  })();

  module.exports = TabStripView;

}).call(this);
