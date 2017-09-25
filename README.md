[![Build Status](https://travis-ci.org/REMnux/salt-states.svg?branch=master)](https://travis-ci.org/REMnux/salt-states)

# REMnux Salt States

WIP: Working on 16.04 support.

## Known Issues

* General Python Dependency Conflicts (believe it has to do with pip and setuptools version)
* Python Package: cybox - will not install properly
* Not all REMnux specific configuration files have been converted over yet

## Goals

* Be 100% compatible with SIFT
* Easy to update and make changes
* Support 16.04 and forward

## How to Use this Repository

1. Have a Ubuntu Desktop VM available
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

## Testing States

If you are on linux or using Docker for Mac you can test every state using a script that resides in the `.ci` directory.

### Testing a Single State

This will run saltstack in a docker container and it mounts the current changes of all the states into the container and then it'll run it. By default debug logging is on, so you'll see a bunch of logging, below is an example of success output.

```bash
 ./.ci/test-state.sh remnux.python-packages.peframe
```

#### Output
```bash
local:
  Name: git - Function: pkg.installed - Result: Changed Started: - 15:26:51.920089 Duration: 28083.27 ms
  Name: python-pip - Function: pkg.installed - Result: Changed Started: - 15:27:20.010772 Duration: 76374.46 ms
  Name: git+https://github.com/guelfoweb/peframe.git@e482def - Function: pip.installed - Result: Changed Started: - 15:28:36.626031 Duration: 13996.589 ms

Summary for local
------------
Succeeded: 3 (changed=3)
Failed:    0
------------
Total states run:     3
Total run time: 118.454 s
```


## Building States
This repository is built to run with SaltStack Minionless setup with a local state tree. What this means is that everything is self container to run on a server where a saltstack base code is installed. 

This allows for different build targets within the saltstack deployment, for now the only install method is `state.apply remnux`.

The states are designed to make use of require and watch statements against the `sls` module, but you can do it against other typical required modules as well, but the benefit of requiring against `sls` is that you can ensure ALL states in a file pass before things continue.

### Requirements for Building State Files
* Use absolute paths when including and referencing other state files.
* Use `sls` require statements when dealing with a large includes, this ensures all states pass properly without having to specify them all.
* Prefix all state names with `remnux-`
* States should be added to the `init.sls` file in it's directory, unless it's purely a dependency for another package. There are two places in the `init.sls` to add, first under the `include:` directive (this ensures that the state is included in the execution) and then under the `test.nop require` directive. **Note:** the `test.nop` is used as a rollup state function to ensure all child states execute properly. As long as all require functions pass, it'll pass.
* All dependencies should be defined as state files. If a python packages requires something to be installed from APT, that package should get an entry in the `remnux/packages` folder, and then it should be included and required by the python package state. 

### How to Test a State Interactively
If you are working on a new state and want to be in a shell where you can just continue to test running the state without loosing history, you can launch into a docker container (so long as you are on linux or using Docker for Mac) and all the states will be mounted into a volume. A script called `./ci/dev-state.sh` is there to set this up for you.

From there you can add your state file using your favorite text editor, make the changes necessary and when you are ready to test it, just run the following command `salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls <state_dot_path>`.

The `<state_dot_path>` will be something like `remnux.packages.state-filename` or `remnux.python-packages.state-filename`

### Example States

#### Python Package Not in PIP

```yaml
include:
  - remnux.packages.git
  - remnux.packages.python-pip

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@e482def
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.python-pip
```

Note: for those not familar with saltstack, `.sls` files are just yaml, and they are "state" definitions. In the example above `remnux-pip-peframe` is just the name of a state(ment), where `pip.installed` is the SaltStack "state function" and then `- name` and `- require` are named arguments to that "state function"


1. First we include `remnux.packages.git` and `remnux.packages.python-pip` -- This is important because it helps SaltStack determine the proper execution order of all the states.
2. Both includes have been added as a require statement using `sls` for the state. -- This is important because it continues to help with the proper execution order and ensures that those state files are executed first and ONLY IF they both pass successful will the `pip.installed` run.
3. In this case peframe isn't in PIP, but it has a setup.py file, so it can be installed using the `pip.installed` state function from SaltStack.

In the end this state when run by itself will ensure that git and python pip are both installed before installing peframe. Git is required to clone the code from github and pip is installed because it uses the setup.py that is in the repo to actually install the module.
