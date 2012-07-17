(function() {
  var Model, applyConfig, config, extend, gradientColor, isAndroid, model;

  Model = require("/lib/Model");

  model = new Model();

  config = model.getConfig();

  isAndroid = Ti.Platform.osname === "android" ? true : false;

  gradientColor = config.theme.barColor;

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

  exports.createMapView = function(dict) {
    var defaults, mapView;
    defaults = {
      top: isAndroid ? 94 : 0
    };
    mapView = Ti.Map.createView(applyConfig(dict, defaults));
    return mapView;
  };

  exports.createMapAnnotation = function(dict) {
    var annotation, defaults;
    defaults = {
      draggable: false,
      animate: true,
      pinColor: Ti.Map.ANNOTATION_GREEN
    };
    annotation = Ti.Map.createAnnotation(applyConfig(dict, defaults));
    return annotation;
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
