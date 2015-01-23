# User controller

async = require 'async'

User = require '../models/user'

module.exports =
	create: (req, res, next) ->
		user = User.create req.body, (err, user) ->
			return next(err) if err?
			res.status(201).json user

	current: (req, res) -> res.json req.user

	updatePassword: (req, res, next) ->
		async.waterfall [
			(cb) -> User.authenticate req.user.username, req.body.currentPassword, cb
			(user, cb) ->
				return next(null, null) if not user?
				user.password = req.body.newPassword
				user.save cb
		], (err, user) ->
			return next(err) if err?
			res.json user