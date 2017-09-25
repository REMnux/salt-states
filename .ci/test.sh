#!/bin/bash

set -x

if [ "x$TRAVIS_TAG" != "x" ]; then
  echo "Detected Event: Tag"
  echo " > TAG: ${TRAVIS_TAG}"
  echo ""
  ./.ci/test-all.sh || exit 1
  exit 0
fi

if [ "$TRAVIS_EVENT_TYPE" != "cron" ]; then
  echo "Detected Event: Push or PR"
  echo ""
  ./.ci/test-changed.sh || exit 1
  exit 0
fi

if [ "$TRAVIS_EVENT_TYPE" = "cron" ]; then
  echo "Detected Event: CRON"
  echo ""
  ./.ci/test-all.sh || exit 1
  exit 0
fi

