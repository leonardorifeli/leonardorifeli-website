#!/usr/bin/env bash
set -e

echo "Starting build in leonardorifeli.com!"
echo 'Testing travis...'

bundle exec travis-lint
bundle exec jekyll build
