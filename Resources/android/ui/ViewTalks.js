(function() {
  var View;

  View = function() {
    var Model, model, rows, self, tableView, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = new ui.createView({
      backgroundColor: "#0000FF"
    });
    tableView = new ui.createTableView();
    self.add(tableView);
    return self;
  };

  module.exports = View;

}).call(this);
