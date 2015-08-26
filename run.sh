#!/bin/sh
bundle install
bundle exec rake db:create
bundle exec shotgun -o 0.0.0.0
