// convenience for using a local copies of dependencies, so they need not be installed globally
// borrowed partially from https://github.com/ilkosta/static-jade-brunch/blob/master/setup.js

var spawn = require('child_process').spawn,
	sysPath = require('path'),
	fs = require('fs')

var execute = function(pathParts, params, callback) {
	callback = callback || function() {}
	var path = sysPath.join.apply(null, pathParts)

	console.log('Executing node ' + path + ' ' + params)

	params.unshift(path)
	var child = spawn('node', params, { stdio: 'inherit' })

	child.on('exit', function(code) { process.exit(code) })
};

switch(process.argv[2]) {
	case 'server':
		execute(['node_modules', 'coffee-script', 'bin', 'coffee'], ['server.coffee'])
		break;
}