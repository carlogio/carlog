# Test controller

mongoose = require 'mongoose'
extend = (require 'util')._extend

Test = require '../models/test'

module.exports =
	load: (req, res, next, id) ->
		Test.load id, (err, val) ->
			return next(err) if err?
			return next(new Error('not found')) if not val?
			req.testVal = val
			next()

	list: (req, res, next) ->
		options =
			page: (req.query.page ? 1) - 1
			perPage: 30

		Test.list options, (err, vals) ->
			return next(err) if err?
			res.json vals

	create: (req, res, next) ->
		val = new Test(req.body)
		val.save (err, val) ->
			return next(err) if err?
			res.status(201).json val

	retrieve: (req, res) ->
		res.json req.testVal

	update: (req, res, next) ->
		val = extend req.testVal, req.body
		val.save (err, val) ->
			return next(err) if err?
			res.json val

	delete: (req, res) ->
		req.testVal.remove (err) ->
			res.status(204).end()

	test: (req, res) ->
		req.testVal.test()
		res.status(204).end()