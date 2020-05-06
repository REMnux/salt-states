[![Build Status](https://travis-ci.org/REMnux/salt-states.svg?branch=master)](https://travis-ci.org/REMnux/salt-states)

# REMnux Salt States

Work in Progress: Working on creating state files.

## Known Issues

Not all state files have been created yet.

## Goals

* Be compatible with SIFT.
* Easy to update and make changes.
* Support Ubuntu 18.04 LTE as the base OS.

## How to Use this Repository

1. Have a [Ubuntu 18.04 Desktop](https://releases.ubuntu.com/18.04/) VM available
2. [Install SaltStack in the VM](#install-saltstack)
3. `git clone https://github.com/REMnux/salt-states.git /srv/salt`
4. `sudo salt-call --local state.sls remnux`
5. Sit back and enjoy

### Install SaltStack

As root run the following commands:

```bash
wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
apt-get update -y
apt-get upgrade -y
apt-get install -y salt-minion git 
systemctl disable salt-minion
systemctl stop salt-minion
echo "file_client: local" > /etc/salt/minion
```

## Testing States

If you are on Linux or using Docker, you can test every state using a script that resides in the `.ci` directory.

### Testing a Single State

This will run SaltStack in a Docker container, mount the current changes of all the states into the container and then run it. By default debug logging is on, so you'll see a bunch of logging, below is an example of success output.

Run this command from the directory where you cloned this salt-states repository.

```bash
 .ci/test-state.sh remnux.python-packages.peframe
```

#### Output
```bash
local:
  Name: git - Function: pkg.installed - Result: Changed Started: - 01:10:43.540606 Duration: 35394.214 ms
  Name: libssl-dev - Function: pkg.installed - Result: Changed Started: - 01:11:18.946678 Duration: 8377.478 ms
  Name: swig - Function: pkg.installed - Result: Changed Started: - 01:11:27.336325 Duration: 5725.027 ms
  Name: python3 - Function: pkg.installed - Result: Clean Started: - 01:11:33.071909 Duration: 862.358 ms
  Name: python3-pip - Function: pkg.installed - Result: Changed Started: - 01:11:33.934581 Duration: 172933.827 ms
  Name: python - Function: pkg.installed - Result: Clean Started: - 01:14:26.880151 Duration: 862.198 ms
  Name: python-pip - Function: pkg.installed - Result: Changed Started: - 01:14:27.742717 Duration: 58663.826 ms
  Name: git+https://github.com/guelfoweb/peframe.git@master - Function: pip.installed - Result: Changed Started: - 01:15:27.562448 Duration: 33464.807 ms

Summary for local
------------
Succeeded: 8 (changed=6)
Failed:    0
------------
Total states run:     8
Total run time: 316.284 s
```

If you see the "Succeeded," you'll know the build works. However, the Docker container within which you installed peframe will have exited. To get interactive access to the container for troubleshooting the state file, see [How to Test a State Interactively](#how-to-test-a-state-interactively).

## Building States
This repository is built to run with SaltStack minionless setup with a local state tree. What this means is that everything is self container to run on a server where a SaltStack base code is installed. 

This allows for different build targets within the saltstack deployment, for now the only install method is `state.apply remnux`.

The states are designed to make use of require and watch statements against the `sls` module, but you can do it against other typical required modules as well, but the benefit of requiring against `sls` is that you can ensure _all_ states in a file pass before things continue.

### Requirements for Building State Files

* Use absolute paths when including and referencing other state files.
* Use `sls` require statements when dealing with a large includes, this ensures all states pass properly without having to specify them all.
* Prefix all state names with `remnux-`
* States should be added to the `init.sls` file in it's directory, unless it's purely a dependency for another package. There are two places in the `init.sls` to add, first under the `include:` directive (this ensures that the state is included in the execution) and then under the `test.nop require` directive. **Note:** the `test.nop` is used as a rollup state function to ensure all child states execute properly. As long as all require functions pass, it'll pass.
* All dependencies should be defined as state files. If a python packages requires something to be installed from _apt_, that package should get an entry in the `remnux/packages` folder, and then it should be included and required by the python package state. 

### How to Test a State Interactively

If you are working on a new state and want to be in a shell where you can just continue to test running the state without loosing history, you can launch into a Docker container (so long as you are on Linux or using Docker) and all the states will be mounted into a volume. A script called `.ci/dev-state.sh` is there to set this up for you.

You can create (or modify) your state file using your favorite text editor. When you are ready to test it, just run the following command `salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls <state_dot_path>`.

The `<state_dot_path>` will be something like `remnux.packages.state-filename` or `remnux.python-packages.state-filename`.

### Example States

#### Python Package Not in PIP

```yaml
include:
  - remnux.packages.git
  - remnux.packages.libssl-dev
  - remnux.packages.swig
  - remnux.packages.python3-pip
  - remnux.packages.python-pip

remnux-pip-peframe:
  pip.installed:
    - name: git+https://github.com/guelfoweb/peframe.git@master
    - bin_env: /usr/bin/pip3
    - require:
      - sls: remnux.packages.git
      - sls: remnux.packages.libssl-dev
      - sls: remnux.packages.swig
      - sls: remnux.packages.python3-pip
      - sls: remnux.packages.python-pip
```

Note: for those not familar with saltstack, `.sls` files are just YAML files, and they are "state" definitions. In the example above `remnux-pip-peframe` is just the name of a state(ment), where `pip.installed` is the SaltStack "state function" and then `- name` and `- require` are named arguments to that "state function." The /usr/bin/pip3 reference ensures that the Python 3 version of PIP will be used.


1. First we include `remnux.packages.git` and `remnux.packages.python3-pip` -- This is important because it helps SaltStack determine the proper execution order of all the states. Same for references to other peframe dependencies (libssl-dev and swig). The reference to python-pip is needed here for some strange reason--even though we'll be using PIP3 for peframe--because without it SaltStack gives an error.
2. The includes have been added as a require statement using `sls` for the state. -- This is important because it continues to help with the proper execution order and ensures that those state files are executed first and _onl if_ they both pass successful will the `pip.installed` run.
3. In this case peframe isn't in PIP, but it has a setup.py file, so it can be installed using the `pip.installed` state function from SaltStack.

In the end this state when run by itself will ensure that git and python pip are both installed before installing peframe. Git is required to clone the code from Github and PIP is installed because it uses the setup.py that is in the repo to actually install the module.
