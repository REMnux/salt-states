#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1

docker run -it --rm --name="remnux-state-${STATE}" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN remnux/saltstack-tester:${DISTRO} \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE} pillar="{remnux_user: root}"
