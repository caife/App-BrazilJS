(function() {
  var Window;

  Window = function(dict) {
    var Model, model, rowSelected, rowSelectedIndex, rows, self, speaker, speakers, tableView, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    rowSelected = null;
    rowSelectedIndex = null;
    rows = [];
    self = new ui.createWindow({
      title: L("speakers")
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
    tableView.addEventListener("click", function(e) {
      var WinSpeaker, speaker_obj, winSpeaker;
      rowSelectedIndex = e.index;
      rowSelected = e.row;
      tableView.selectRow(e.index, {
        animated: false
      });
      speaker_obj = e.rowData.speaker_obj;
      WinSpeaker = require("/ui/WinSpeaker");
      winSpeaker = new WinSpeaker(speaker_obj);
      return dict.currenTab.open(winSpeaker);
    });
    self.addEventListener("focus", function() {
      return setTimeout(function() {
        if (rowSelectedIndex !== null) {
          return tableView.deselectRow(rowSelectedIndex, {
            duration: 150
          });
        }
      }, 100);
    });
    return self;
  };

  module.exports = Window;

}).call(this);
