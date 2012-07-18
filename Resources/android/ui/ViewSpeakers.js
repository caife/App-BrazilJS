(function() {
  var View;

  View = function() {
    var Model, model, rows, self, speaker, speakers, tableView, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rows = [];
    self = ui.createView({
      backgroundColor: "#FFFFFF"
    });
    speakers = model.getSpeakers();
    rows = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = speakers.length; _i < _len; _i++) {
        speaker = speakers[_i];
        _results.push(ui.createSpeakerRow(speaker));
      }
      return _results;
    })();
    tableView = new ui.createTableView({
      data: rows
    });
    self.add(tableView);
    return self;
  };

  module.exports = View;

}).call(this);
