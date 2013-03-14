#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Installs npm
# https://gist.github.com/TooTallNate/3288316
VERSION=0.8.18
PLATFORM=linux
ARCH=x86
PREFIX="/usr/local"

mkdir -p "$PREFIX" && \
curl http://nodejs.org/dist/v$VERSION/node-v$VERSION-$PLATFORM-$ARCH.tar.gz \
  | sudo tar xzvf - --strip-components=1 -C "$PREFIX"

# Install se-interpreter node app.
sudo npm install -g se-interpreter
