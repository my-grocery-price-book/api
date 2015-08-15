#!/bin/sh
bundle install
bundle exec rake db:create
bundle exec puma -p 9393
