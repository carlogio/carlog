# Test model

mongoose = require 'mongoose'

TestSchema = new mongoose.Schema
	name:
		type: String
		default: ''
		trim: true

TestSchema.path('name').required true, 'Name cannot be blank'

TestSchema.methods =
	test: () -> console.log "Test! #{this.name}"

TestSchema.statics =
	load: (id, cb) -> @findById id, cb
	list: (options, cb) ->
		criteria = options.criteria || {}

		this.find(criteria).limit(options.perPage).skip(options.perPage * options.page).exec cb

module.exports = mongoose.model 'Test', TestSchema