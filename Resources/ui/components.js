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
      pincolor: Ti.Map.ANNOTATION_RED
    };
    annotation = Ti.Map.createAnnotation(applyConfig(dict, defaults));
    return annotation;
  };

  exports.createTableView = function(dict) {
    var defaults, tableView;
    defaults = {
      top: 0
    };
    tableView = Ti.UI.createTableView(applyConfig(dict, defaults));
    return tableView;
  };

  exports.createSpeakerRow = function(dict) {
    var company, image, imageSize, leftSpaceOfLabels, name, self, spaceFromBorder;
    spaceFromBorder = isAndroid ? 0 : "5dp";
    imageSize = isAndroid ? "70dp" : "60dp";
    leftSpaceOfLabels = isAndroid ? "85dp" : "70dp";
    self = Ti.UI.createTableViewRow({
      speaker_obj: dict,
      hasChild: isAndroid ? false : true,
      height: Ti.UI.SIZE,
      className: "speaker"
    });
    image = Ti.UI.createImageView({
      image: "/images/speakers/" + dict.picture,
      left: spaceFromBorder,
      top: spaceFromBorder,
      bottom: spaceFromBorder,
      height: imageSize,
      width: imageSize
    });
    self.add(image);
    name = Ti.UI.createLabel({
      text: dict.name,
      left: leftSpaceOfLabels,
      top: "14dp",
      color: "#000000",
      highlightedColor: "#FFFFFF",
      font: {
        fontWeight: "bold",
        fontSize: "18dp"
      }
    });
    self.add(name);
    company = Ti.UI.createLabel({
      text: dict.company,
      left: leftSpaceOfLabels,
      top: "35dp",
      color: "#666666",
      highlightedColor: "#FFFFFF",
      font: {
        fontSize: "14dp"
      }
    });
    self.add(company);
    return self;
  };

  exports.createTalkRow = function(dict) {
    var leftSpaceOfLabels, self, timeLabel, titleLabel;
    leftSpaceOfLabels = "10dp";
    self = Ti.UI.createTableViewRow({
      talk_obj: dict,
      hasChild: isAndroid ? false : true,
      height: "60dp",
      className: "talk"
    });
    titleLabel = Ti.UI.createLabel({
      text: dict.name,
      left: leftSpaceOfLabels,
      top: "10dp",
      color: "#000000",
      highlightedColor: "#FFFFFF",
      font: {
        fontSize: "18dp",
        fontWeight: "bold"
      }
    });
    self.add(titleLabel);
    timeLabel = Ti.UI.createLabel({
      text: "" + dict.hour + " - " + dict.date,
      left: leftSpaceOfLabels,
      top: "33dp",
      color: "#999999",
      highlightedColor: "#FFFFFF",
      font: {
        fontSize: "14dp"
      }
    });
    self.add(timeLabel);
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
