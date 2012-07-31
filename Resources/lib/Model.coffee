class Model

	constructor: ->	
		@config = "config"
		@speakers = "speakers"
		@talks = "talks"


	# getConfig
	getConfig: ->
		if Ti.App.Properties.hasProperty @config
			Ti.App.Properties.getObject @config


	# getSpeakers
	getSpeakers: ->
		if Ti.App.Properties.hasProperty @speakers
			Ti.App.Properties.getList @speakers


	# setTalks
	setTalks: (data) ->
		Ti.App.Properties.setList @talks, data


	# getTalks
	getTalks: ->
		if Ti.App.Properties.hasProperty @talks
			Ti.App.Properties.getList @talks


	# getSpeaker
	getSpeaker: (id) ->
		if Ti.App.Properties.hasProperty @speakers
			speakers = Ti.App.Properties.getList @speakers
			speakers[id]

	# getSpeaker
	getSpeakerWithName: (name) ->

		if Ti.App.Properties.hasProperty @speakers
			speakers = Ti.App.Properties.getList @speakers

			for speaker in speakers
				if speaker.name == name
					return speaker

module.exports = Model