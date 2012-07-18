(function() {
  var View;

  View = function() {
    var Model, annotation, config, mapView, model, self, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    config = model.getConfig().localization;
    self = new ui.createView({
      backgroundColor: "#FFFFFF"
    });
    annotation = new ui.createMapAnnotation({
      latitude: config.latitude,
      longitude: config.longitude,
      title: config.name,
      subtitle: config.address
    });
    mapView = new ui.createMapView({
      annotations: [annotation],
      region: {
        latitude: config.latitude,
        longitude: config.longitude,
        latitudeDelta: 0.005,
        longitudeDelta: 0.005
      }
    });
    self.add(mapView);
    return self;
  };

  module.exports = View;

}).call(this);
