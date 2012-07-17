(function() {
  var Window;

  Window = function() {
    var Model, model, rows, self, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = new ui.createWindow({
      title: L("twitter")
    });
    return self;
  };

  module.exports = Window;

}).call(this);
