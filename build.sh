#!/usr/bin/env bash
set -e

echo 'Testing travis...'

bundle exec travis-lint
bundle exec jekyll build