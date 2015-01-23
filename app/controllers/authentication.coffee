# Authentication controller, using passport.js

passport = require 'passport'
{BasicStrategy} = require 'passport-http'

User = require '../models/user'

passport.serializeUser (user, cb) -> cb null, user._id
passport.deserializeUser (id, cb) -> User.findById id, cb

# Basic authentication
passport.use new BasicStrategy User.authenticate

module.exports = passport