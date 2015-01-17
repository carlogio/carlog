# Configuration/setup for express

bodyParser = require 'body-parser'

config = require './env'

module.exports = (app) ->
	app.engine 'jade', (require 'jade').__express
	app.set 'views', "#{config.root}/app/views"
	app.set 'view engine', 'jade'

	app.use (req, res, next) ->
		res.locals.config = config
		next()

	app.use bodyParser.json()