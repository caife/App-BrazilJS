(function() {
  var Window;

  Window = function() {
    var Localization, Model, annotation, config, mapView, model, self, ui;
    Model = require("/lib/Model");
    Localization = require("/lib/Localization");
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
    mapView.addEventListener("click", function(e) {
      var mapOptions;
      if (e.clicksource === "rightButton") {
        mapOptions = Ti.UI.createOptionDialog({
          title: L("title_map_options"),
          destructive: 2,
          options: [L("call"), L("route"), L("cancel")]
        });
        mapOptions.show();
        return mapOptions.addEventListener("click", function(e) {
          switch (e.index) {
            case 0:
              return Localization.call(config.phone);
            case 1:
              return Localization.makeRoute(config.latitude, config.longitude);
          }
        });
      }
    });
    return self;
  };

  module.exports = Window;

}).call(this);
