# Configuration/setup for express

bodyParser = require 'body-parser'
config = require './env'
express = require 'express'
stylus = require 'stylus'
nib = require 'nib'

module.exports = (app) ->

	# Setup Jade to render templates from app/views
	app.engine 'jade', (require 'jade').__express
	app.set 'views', "#{config.root}/app/views"
	app.set 'view engine', 'jade'

	# Enable stylus middleware on the app/public directory
	app.use stylus.middleware
		src: "#{config.root}/app/public"
		compile: (str, path) ->
			stylus(str).set('filename', path).use(nib())

	# Serve static resources from app/public.
	# (includes auto-generated files from stylus)
	app.use express.static("#{config.root}/app/public")

	# Serve third-party resources from bower at /thirdparty
	app.use '/thirdparty', express.static("#{config.root}/bower_components")

	app.use (req, res, next) ->
		res.locals.config = config
		next()

	app.use bodyParser.json()