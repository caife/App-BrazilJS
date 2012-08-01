# Bootstrap application (set file data in Properties)
Bootstrap = require "/lib/Bootstrap"
Bootstrap.setInitialConfigutarion()

# Open ApplicationWindow
ApplicationWindow = require "/ui/ApplicationWindow"
new ApplicationWindow().open()