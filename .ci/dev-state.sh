#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1

docker run -it --rm --name="remnux-state-${STATE}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:xenial:${DISTRO} \
  /bin/bash
