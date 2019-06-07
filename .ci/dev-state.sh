#!/bin/bash

set -x

STATE=$1

docker run -it --rm --name="remnux-state-${STATE}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:bionic \
  /bin/bash
