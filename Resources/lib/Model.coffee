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

	# getTalks
	getTalks: ->

		if Ti.App.Properties.hasProperty @talks
			Ti.App.Properties.getList @talks

module.exports = Model