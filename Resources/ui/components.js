(function() {
  var applyConfig, extend, gradientColor, isAndroid;

  isAndroid = Ti.Platform.osname === "android" ? true : false;

  gradientColor = "#006400";

  exports.createWindow = function(dict) {
    var defaults, window;
    defaults = {
      barColor: gradientColor
    };
    window = Ti.UI.createWindow(applyConfig(dict, defaults));
    return window;
  };

  exports.createView = function(dict) {
    var defaults, view;
    defaults = {
      top: isAndroid ? 94 : 0
    };
    view = Ti.UI.createView(applyConfig(dict, defaults));
    return view;
  };

  exports.createTableView = function(dict) {
    var defaults, tableView;
    defaults = {
      top: isAndroid ? 94 : 0
    };
    tableView = Ti.UI.createTableView(applyConfig(dict, defaults));
    return tableView;
  };

  exports.createTalkerRow = function(dict) {
    var self;
    self = Ti.UI.createTableViewRow({
      title: dict.name
    });
    return self;
  };

  applyConfig = function(object, config) {
    return extend(extend({}, object), config);
  };

  extend = exports.extend = function(object, properties) {
    var key, val;
    for (key in properties) {
      val = properties[key];
      object[key] = val;
    }
    return object;
  };

}).call(this);
