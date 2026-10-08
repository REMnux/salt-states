# Ubuntu 24.04 with the Salt onedir bundle that the REMnux installer (Cast) installs, so states
# are tested the way `remnux install` runs them. TARGETARCH comes from `docker build --platform`.
FROM ubuntu:24.04
ARG TARGETARCH
ARG SALT_VERSION=3006.9
RUN set -e; export DEBIAN_FRONTEND=noninteractive; \
    case "$TARGETARCH" in \
      amd64) a=x86_64; sha=8dd41dd27e8d0bf9ff3246448d5cbf9a794d8f9f7d201d4a1c3d12453a429b37 ;; \
      arm64) a=arm64;  sha=bb93f248dc5d559c90e87693d8bce5b0d7d416e13d881d099fa0259a1ed70dfe ;; \
      *) echo "unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
    esac; \
    apt-get update; apt-get install -y wget xz-utils ca-certificates git gnupg sudo file; \
    wget -q -O /tmp/salt.tar.xz "https://packages.broadcom.com/artifactory/saltproject-generic/onedir/${SALT_VERSION}/salt-${SALT_VERSION}-onedir-linux-${a}.tar.xz"; \
    echo "${sha}  /tmp/salt.tar.xz" | sha256sum -c -; \
    mkdir -p /opt/saltstack && tar -xJf /tmp/salt.tar.xz -C /opt/saltstack && rm /tmp/salt.tar.xz; \
    ln -s /opt/saltstack/salt/salt-call /usr/local/bin/salt-call; \
    mkdir -p /etc/salt && echo "file_client: local" > /etc/salt/minion
