(function() {
  var Window;

  Window = function() {
    var Model, model, rows, self, tableView, talk, talks, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = new ui.createWindow({
      title: L("talks")
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
      data: rows
    });
    self.add(tableView);
    return self;
  };

  module.exports = Window;

}).call(this);
