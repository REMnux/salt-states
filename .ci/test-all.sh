#!/bin/bash

docker run -it --rm --name="remnux-test-all" -v `pwd`/remnux:/srv/salt/remnux --cap-add SYS_ADMIN remnux/saltstack-tester:bionic:focal \
  salt-call -l info --local --retcode-passthrough --state-output=mixed state.sls remnux pillar='{"remnux_user": "root"}'
