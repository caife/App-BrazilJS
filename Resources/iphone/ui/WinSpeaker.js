(function() {
  var Window;

  Window = function(speaker) {
    var headerView, imageProfile, labelCompany, labelName, rowDescription, rowTwitter, self, tableView, ui;
    ui = require("/ui/components");
    self = new ui.createWindow({
      title: L("speaker")
    });
    headerView = Ti.UI.createView({
      height: Ti.UI.SIZE,
      backgroundColor: "transparent"
    });
    imageProfile = Ti.UI.createImageView({
      image: "/images/speakers/" + speaker.picture,
      height: 65,
      width: 65,
      top: 10,
      left: 10,
      borderColor: "#444444",
      borderWidth: 1,
      borderRadius: 4
    });
    headerView.add(imageProfile);
    labelName = Ti.UI.createLabel({
      text: speaker.name,
      left: 85,
      top: 20,
      color: "#000000",
      shadowColor: "#FFFFFF",
      shadowOffset: {
        x: 0,
        y: 1
      },
      font: {
        fontSize: 18,
        fontWeight: "bold"
      }
    });
    headerView.add(labelName);
    labelCompany = Ti.UI.createLabel({
      text: speaker.company,
      left: 85,
      top: 40,
      color: "#333333",
      shadowColor: "#FFFFFF",
      shadowOffset: {
        x: 0,
        y: 1
      },
      font: {
        fontSize: 15
      }
    });
    headerView.add(labelCompany);
    rowTwitter = Ti.UI.createTableViewRow({
      height: 44
    });
    rowTwitter.add(Ti.UI.createLabel({
      text: L("twitter"),
      left: 10,
      font: {
        fontSize: 16,
        fontWeight: "bold"
      }
    }));
    rowTwitter.add(Ti.UI.createLabel({
      text: "@" + speaker.twitter_handle,
      right: 10,
      font: {
        fontSize: 16
      }
    }));
    rowDescription = Ti.UI.createTableViewRow({
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
    });
    rowDescription.add(Ti.UI.createLabel({
      text: speaker.description,
      width: 280,
      height: Ti.UI.SIZE,
      top: 10,
      bottom: 10,
      ellipsize: false,
      font: {
        fontSize: 16
      }
    }));
    tableView = new ui.createTableView({
      headerView: headerView,
      style: Ti.UI.iPhone.TableViewStyle.GROUPED,
      data: [rowTwitter, rowDescription]
    });
    self.add(tableView);
    return self;
  };

  module.exports = Window;

}).call(this);
