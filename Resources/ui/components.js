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
      top: 0
    };
    mapView = Ti.Map.createView(applyConfig(dict, defaults));
    return mapView;
  };

  exports.createMapAnnotation = function(dict) {
    var annotation, defaults;
    defaults = {
      draggable: false,
      animate: true,
      pincolor: Ti.Map.ANNOTATION_GREEN
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

  exports.createSpeakerRow = function(dict) {
    var company, image, name, self;
    self = Ti.UI.createTableViewRow({
      speaker_obj: dict,
      height: Ti.UI.SIZE
    });
    image = Ti.UI.createImageView({
      image: "/images/speakers/" + dict.picture,
      left: "5dp",
      top: "5dp",
      bottom: "5dp",
      height: "50dp",
      width: "50dp"
    });
    self.add(image);
    name = Ti.UI.createLabel({
      text: dict.name,
      left: "60dp",
      top: "10dp",
      font: {
        fontWeight: "bold",
        fontSize: "16dp"
      }
    });
    self.add(name);
    company = Ti.UI.createLabel({
      text: dict.company,
      left: "60dp",
      top: "30dp",
      color: "#666",
      font: {
        fontSize: "14dp"
      }
    });
    self.add(company);
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
