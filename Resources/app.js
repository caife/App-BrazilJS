(function() {
  var ApplicationWindow, Bootstrap;

  Bootstrap = require("/lib/Bootstrap");

  Bootstrap.setInitialConfigutarion();

  ApplicationWindow = require("ui/ApplicationWindow");

  new ApplicationWindow().open();

}).call(this);
