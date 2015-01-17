# CarLog Backend

This folder contains the node.js backend API server for CarLog.

## Configuration

System configuration values are stored in `config/env/`, in a file named after the `NODE_ENV` environment variable, defaulting to `development`. Setting this environment variable allows overriding the configuration used. As a convenience, there is a git ignore in place for dev-*.coffee (e.g., set NODE_ENV=dev-test and dev-test.coffee will be loaded and used for configuration).

MongoDB is required. With the default development environment configuration, the server will attempt to use the database `carlog_dev` on `localhost`.

## Running

To fire up the server, `npm run server` may be used. Alternatively, if coffee-script is installed globally, you can run `coffee server.coffee`.