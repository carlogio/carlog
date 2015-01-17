# passport.js configuration

passport = require 'passport'

module.exports = (app) ->
	app.use passport.initialize()