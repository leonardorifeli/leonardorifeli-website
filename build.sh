#!/usr/bin/env bash
set -e

echo "Starting build in leonardo.rifeli.tech!"
echo 'Testing travis...'

bundle exec travis-lint
bundle exec jekyll build

echo "Finished build in leonardo.rifeli.tech!"