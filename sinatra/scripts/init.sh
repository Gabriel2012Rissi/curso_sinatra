#!/bin/sh
set -e

# Create database and run migrations
bundle exec rake db:create
bundle exec rake db:migrate

# If the environment is development or test, seed the database
if [ "${APP_ENV}" = "development" ] || [ "${APP_ENV}" = "test" ]; then
  bundle exec rake db:seed
fi

exec "$@"