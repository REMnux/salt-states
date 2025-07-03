#!/bin/bash

DISTRO=${DISTRO:="focal"}
STATE=$1
echo salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls remnux.${STATE}
docker run -it --rm --name="remnux-state-${DISTRO}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN ghcr.io/ekristen/cast-tools/saltstack-tester:${DISTRO}-3006 \
  /bin/bash
