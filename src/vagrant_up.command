#!/bin/bash

#  vagrant_up.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

cd ~/coreos-osx-cluster/coreos-vagrant
vagrant up

# path to the bin folder where we store our binary files
export PATH=$PATH:${HOME}/coreos-osx-cluster/bin

# set fleetctl tunnel
# Add vagrant ssh key to ssh-agent
###vagrant ssh-config core-01 | sed -n "s/IdentityFile//gp" | xargs ssh-add
ssh-add ~/.vagrant.d/insecure_private_key

export FLEETCTL_TUNNEL=127.0.0.1:2322
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
echo "fleetctl list-machines :"
fleetctl list-machines

# open bash shell
/bin/bash
