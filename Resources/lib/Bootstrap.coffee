exports.setInitialConfigutarion = ->

	extension = "json"
	files = [
		{ type: "Object", name: "Config" }
		{ type: "Array", name: "Speakers" }
	]

	for file in files
		do (file) ->

			# Get physical file
			property_name = file.name.toLowerCase()
			file_name = "#{file.name}.#{extension}"
			physical_file = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory + Ti.Filesystem.separator + "data", file_name);

			# If file exists
			if (physical_file.exists())
				
				# Get file content and JSON parse it
				file_content = JSON.parse physical_file.read().text

				# If type is Object, use setObject
				if file.type == "Object"
					Ti.App.Properties.setObject(property_name, file_content)
				else if file.type == "Array"
					Ti.App.Properties.setList(property_name, file_content)