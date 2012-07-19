(function() {
  var ActionBarView;

  ActionBarView = (function() {

    function ActionBarView(dict) {
      var button, _i, _len, _ref;
      this.dict = dict;
      this.buttonOffset = 0;
      this.actionBarView = Ti.UI.createView({
        height: "44dp",
        top: 0,
        backgroundColor: this.dict.backgroundColor
      });
      if (typeof this.dict.title !== "undefined") {
        this.actionBarView.add(Ti.UI.createLabel({
          text: this.dict.title,
          left: "5dp",
          color: this.dict.titleColor,
          font: {
            fontSize: "18dp",
            fontWeight: "bold"
          }
        }));
      } else {
        this.actionBarView.add(Ti.UI.createImageView({
          image: this.dict.icon,
          left: "5dp"
        }));
      }
      _ref = this.dict.buttons;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        button = _ref[_i];
        this.createActionBarButton(button);
      }
      return this.actionBarView;
    }

    ActionBarView.prototype.createActionBarButton = function(b) {
      var button, buttonIcon, buttonLabel, self;
      self = this;
      button = Ti.UI.createView({
        width: "" + b.width + "dp",
        right: "" + this.buttonOffset + "dp"
      });
      if (b.title) {
        buttonLabel = Ti.UI.createLabel({
          text: b.title,
          color: this.dict.titleColor,
          height: Ti.UI.SIZE,
          width: Ti.UI.SIZE,
          textAlign: "center",
          font: {
            fontSize: "14dp",
            fontWeight: "bold"
          }
        });
        button.add(buttonLabel);
      } else if (b.icon) {
        buttonIcon = Ti.UI.createImageView({
          image: b.icon,
          height: "32dp",
          width: "32dp"
        });
        button.add(buttonIcon);
      }
      this.actionBarView.add(button);
      this.actionBarView.add(Ti.UI.createView({
        backgroundColor: "#DEDEDE",
        width: 1,
        height: Ti.UI.FILL,
        right: this.buttonOffset + b.width + 1 + "dp"
      }));
      button.addEventListener("click", function() {
        return self.actionBarView.fireEvent("buttonPress", {
          id: b.id
        });
      });
      button.addEventListener("touchstart", function() {
        return this.setBackgroundColor(self.dict.selectedColor);
      });
      button.addEventListener("touchend", function() {
        return this.setBackgroundColor("transparent");
      });
      button.addEventListener("touchcancel", function() {
        return this.setBackgroundColor("transparent");
      });
      return this.buttonOffset += b.width + 7;
    };

    return ActionBarView;

  })();

  module.exports = ActionBarView;

}).call(this);
