(function() {

  exports.setInitialConfigutarion = function() {
    var extension, file, files, _i, _len, _results;
    extension = "json";
    files = [
      {
        type: "Object",
        name: "Config"
      }, {
        type: "Array",
        name: "Speakers"
      }, {
        type: "Array",
        name: "Talks"
      }
    ];
    _results = [];
    for (_i = 0, _len = files.length; _i < _len; _i++) {
      file = files[_i];
      _results.push((function(file) {
        var file_content, file_name, physical_file, property_name;
        property_name = file.name.toLowerCase();
        file_name = "" + file.name + "." + extension;
        physical_file = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory + Ti.Filesystem.separator + "data", file_name);
        if (physical_file.exists()) {
          file_content = JSON.parse(physical_file.read().text);
          if (file.type === "Object") {
            return Ti.App.Properties.setObject(property_name, file_content);
          } else if (file.type === "Array") {
            return Ti.App.Properties.setList(property_name, file_content);
          }
        }
      })(file));
    }
    return _results;
  };

}).call(this);
