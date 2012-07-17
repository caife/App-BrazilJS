(function() {
  var Window;

  Window = function() {
    var Model, model, rows, self, speaker, speakers, tableView, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = new ui.createView();
    tableView = new ui.createTableView();
    self.add(tableView);
    speakers = model.getSpeakers();
    rows = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = speakers.length; _i < _len; _i++) {
        speaker = speakers[_i];
        _results.push(ui.createTalkerRow(speaker));
      }
      return _results;
    })();
    tableView.setData(rows);
    return self;
  };

  module.exports = Window;

}).call(this);
