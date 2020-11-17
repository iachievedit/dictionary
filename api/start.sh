#!/bin/sh

cd /apps/dictionary-api
bundle exec rackup -D --host 0.0.0.0 -p 9000
nginx

