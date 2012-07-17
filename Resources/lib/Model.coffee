class Model

	constructor: ->	
		
		@fileNames =
			speakers: "Speakers.json"
			talks: "Talks.json"

	# getSpeakers
	getSpeakers: ->
	
		file = Titanium.Filesystem.getFile("#{@fileNames.speakers}")

		Ti.API.info file

		response = JSON.parse file.read().text

		response


module.exports = Model