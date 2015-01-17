# User data model

mongoose = require 'mongoose'
async = require 'async'
credential = require 'credential'

UserSchema = new mongoose.Schema
	username:
		type: String
		required: true
		unique: true
		index:
			unique: true
	password:
		type: String
		required: true

UserSchema.pre 'save', (next) ->
	# only hash if the password has been changed
	return next() if not @isModified 'password'

	credential.hash @password, (err, hash) =>
		return next err if err?
		@password = hash
		next()

UserSchema.methods.comparePassword = (candidate, cb) ->
	credential.verify @password, candidate, cb

UserSchema.statics.authenticate = (username, password, cb) ->
	User = mongoose.model 'User'

	async.waterfall [
		(cb) -> User.findOne { username }, cb
		(user, cb) ->
			return cb 'invalid credentials' if not user?
			user.comparePassword password, (err, isMatch) -> cb err, user, isMatch
		(user, isMatch, cb) ->
			return cb 'invalid credentials' if not isMatch
			cb null, user
	], cb

module.exports = mongoose.model 'User', UserSchema