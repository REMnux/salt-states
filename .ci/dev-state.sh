#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1

docker run -it --rm --name="remnux-state-${STATE}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN remnux/saltstack-tester:${DISTRO} \
  /bin/bash
