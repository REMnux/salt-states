# REMnux Salt States

**Important Note:** WIP -- Everything subject to change! Instructions may or may not work as this is being heavily developed.

**Important Note:** Ubuntu 14.04 Trusty is the only distro currently supported at this time.

## Known Issues

* General Python Dependency Conflicts (believe it has to do with pip and setuptools version)
* Python Package: cybox - will not install properly
* Not all REMnux specific configuration files have been converted over yet

## Goals

* Be 100% compatible with SIFT
* Easy to update and make changes
* Support 14.04 and 16.04

## How to Use this Repository

1. Have a 14.04 desktop VM
2. [Install SaltStack](#install-saltstack)
3. `git clone https://github.com:REMnux/states.git /srv/salt/remnux`
4. `sudo salt-call state.apply`
5. Sit back and enjoy

### Install SaltStack

```bash
wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" | tee /etc/apt/sources.list.d/saltstack.list

apt-get install salt-minion

echo "file_client: local" > /etc/salt/minion
```
