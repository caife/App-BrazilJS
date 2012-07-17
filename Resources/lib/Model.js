(function() {
  var Model;

  Model = (function() {

    function Model() {
      this.fileNames = {
        speakers: "Speakers.json",
        talks: "Talks.json"
      };
    }

    Model.prototype.getSpeakers = function() {
      var file, response;
      file = Titanium.Filesystem.getFile("" + this.fileNames.speakers);
      Ti.API.info(file);
      response = JSON.parse(file.read().text);
      return response;
    };

    return Model;

  })();

  module.exports = Model;

}).call(this);
