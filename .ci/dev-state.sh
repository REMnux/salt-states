#!/bin/bash

set -x

DISTRO=${DISTRO:="focal"}
STATE=$1

docker run -it --rm --name="remnux-state-${DISTRO}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN remnux/saltstack-tester:${DISTRO} \
  /bin/bash
