(function() {
  var Model;

  Model = (function() {

    function Model() {
      this.config = "config";
      this.speakers = "speakers";
      this.talks = "talks";
    }

    Model.prototype.getConfig = function() {
      if (Ti.App.Properties.hasProperty(this.config)) {
        return Ti.App.Properties.getObject(this.config);
      }
    };

    Model.prototype.getSpeakers = function() {
      if (Ti.App.Properties.hasProperty(this.speakers)) {
        return Ti.App.Properties.getList(this.speakers);
      }
    };

    return Model;

  })();

  module.exports = Model;

}).call(this);
