#!/bin/sh
docker-compose build
docker-compose run --rm web yarn install
docker-compose run --rm web bundle install
docker-compose run --rm web bundle exec rails db:setup
docker-compose run --rm web bundle exec rails db:test:prepare
