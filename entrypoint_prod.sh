#!/bin/bash
set -e

#echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf
#sysctl -p

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

export SECRET_KEY_BASE=$(rails secret)
RAILS_ENV=production rails db:create
RAILS_ENV=production rails db:migrate db:seed
yarn install --check-files
RAILS_ENV=production rails assets:precompile
RAILS_ENV=production bundle exec rails webpacker:compile
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
