(function() {
  var Model;

  Model = (function() {

    function Model() {
      this.fileNames = {
        config: "Config.json",
        speakers: "Speakers.json",
        talks: "Talks.json"
      };
    }

    Model.prototype.getConfig = function() {
      var file, response;
      file = Titanium.Filesystem.getFile("" + this.fileNames.config);
      response = JSON.parse(file.read().text);
      return response;
    };

    Model.prototype.getSpeakers = function() {
      var file, response;
      file = Titanium.Filesystem.getFile("" + this.fileNames.speakers);
      response = JSON.parse(file.read().text);
      return response;
    };

    return Model;

  })();

  module.exports = Model;

}).call(this);
