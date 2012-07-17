(function() {
  var Window;

  Window = function() {
    var Model, annotation, config, mapView, model, self, ui;
    Model = require("/lib/Model");
    ui = require("/ui/components");
    model = new Model();
    config = model.getConfig().localization;
    self = new ui.createWindow({
      title: L("localization")
    });
    mapView = new ui.createMapView({
      region: {
        latitude: config.latitude,
        longitude: config.longitude,
        latitudeDelta: 0.005,
        longitudeDelta: 0.005
      }
    });
    annotation = new ui.createMapAnnotation({
      latitude: config.latitude,
      longitude: config.longitude,
      title: config.name,
      subtitle: config.address,
      rightButton: Ti.UI.iPhone.SystemButton.CONTACT_ADD
    });
    mapView.addAnnotation(annotation);
    self.add(mapView);
    return self;
  };

  module.exports = Window;

}).call(this);
