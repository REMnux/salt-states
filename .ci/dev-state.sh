#!/bin/bash

set -x

STATE=$1

docker run -it --rm --name="remnux-state-${STATE}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN sansdfir/sift-salt-tester \
  /bin/bash
