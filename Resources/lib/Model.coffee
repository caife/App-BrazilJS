class Model

	constructor: ->	
		
		@fileNames =
			config: "Config.json"
			speakers: "Speakers.json"
			talks: "Talks.json"

	getConfig: ->

		file = Titanium.Filesystem.getFile("#{@fileNames.config}");

		response = JSON.parse file.read().text

		response

	# getSpeakers
	getSpeakers: ->
	
		file = Titanium.Filesystem.getFile("#{@fileNames.speakers}")

		response = JSON.parse file.read().text

		response


module.exports = Model