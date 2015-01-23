# Routes

express = require 'express'

authentication = require './controllers/authentication'

apiAuthentication = authentication.authenticate 'basic', session: false

testApi = do (test = require './controllers/test') ->
	router = express.Router()

	router.param 'testid', test.load

	router.route('/test')
		.get(test.list)
		.post(test.create)

	router.route('/test/:testid')
		.get(test.retrieve)
		.put(test.update)
		.delete(test.delete)

	router.get('/test/:testid/test', test.test)

	router

userApi = do (user = require './controllers/user') ->
	router = express.Router()

	router.route('/user')
		.get(apiAuthentication, user.current)
		.post(user.create)

	router.route('/user/password')
		.put(apiAuthentication, user.updatePassword)

	router

is404 = (err) ->
	# we treat errors as 404 under certain circumstances
	/\bnot found\b|\bCast to ObjectId failed\b/.test err?.message

module.exports = (app) ->
	app.get '/', (req, res) ->
		res.render 'index', title: 'Home'

	api = express.Router()

	api.use testApi
	api.use userApi

	api.use (err, req, res, next) ->
		return next() if is404 err
		console.error err.stack
		res.sendStatus 500

	api.use (req, res) ->
		res.sendStatus 404

	app.use '/api', api

	app.use (err, req, res, next) ->
		return next() if is404 err
		console.error(err.stack)
		res.status(500).render('500', { error: err.message })

	app.use (req, res) ->
		# assume 404 at this point, since no middleware responded and our error handler ignored the error
		res.status(404).render('404', { url: req.originalUrl, error: 'Not found', })