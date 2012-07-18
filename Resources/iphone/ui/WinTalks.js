(function() {
  var Window;

  Window = function() {
    var Model, model, rows, self, tableView, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = new ui.createWindow({
      title: L("talks")
    });
    tableView = new ui.createTableView();
    self.add(tableView);
    return self;
  };

  module.exports = Window;

}).call(this);
