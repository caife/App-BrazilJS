(function() {
  var View;

  View = function() {
    var Model, model, rows, self, tableView, talk, talks, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = ui.createView({
      backgroundColor: "#FFFFFF"
    });
    talks = model.getTalks();
    rows = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = talks.length; _i < _len; _i++) {
        talk = talks[_i];
        _results.push(ui.createTalkRow(talk));
      }
      return _results;
    })();
    tableView = new ui.createTableView({
      separatorColor: "#BEBEBE",
      data: rows
    });
    self.add(tableView);
    return self;
  };

  module.exports = View;

}).call(this);
