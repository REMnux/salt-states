# Name: Docker
# Website: https://www.docker.com
# Description: Run and manage containers.
# Category: General Utilities
# Author: Docker Inc.
# License: Apache License 2.0: https://github.com/moby/moby/blob/master/LICENSE
# Notes: 

include:
  - remnux.repos.docker
  - remnux.tools.docker-compose

docker-docker-engine:
  pkg.removed:
    - name: docker-engine

docker-docker-ce:
  pkg.installed:
    - name: docker-ce
    - require:
      - file: remnux-docker-repo
      - pkg: docker-docker-engine
      - sls: remnux.tools.docker-compose
