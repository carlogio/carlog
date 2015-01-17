# Main server startup/entry point

fs = require 'fs'
express = require 'express'
mongoose = require 'mongoose'

config = require './config/env'

# Setup mongo connection
connect = () ->
	options =
		server:
			socketOptions:
				keepAlive: 1

	mongoose.connect config.db, options

connect()

mongoose.connection.on 'error', console.log
mongoose.connection.on 'disconnected', connect

# Set up express
app = express()

(require './config/express') app
(require './config/passport') app
(require './app/routes') app

server = app.listen process.env.PORT or 3000, () ->
	console.log "Express started on #{server.address().address}:#{server.address().port}"

module.exports = app