#!/bin/bash

#  vagrant_up.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

function pause(){
read -p "$*"
}

cd ~/coreos-osx-cluster/coreos-vagrant
vagrant reload

# path to the bin folder where we store our binary files
export PATH=$PATH:${HOME}/coreos-osx-cluster/bin

# set fleetctl tunnel
# Add vagrant ssh key to ssh-agent
###vagrant ssh-config corec-01 | sed -n "s/IdentityFile//gp" | xargs ssh-add
###ssh-add ~/.vagrant.d/insecure_private_key

export FLEETCTL_TUNNEL=127.0.0.1:2322
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
echo "fleetctl list-machines :"
fleetctl list-machines

# install fleet units
echo "Installing fleet units from '~/coreos-osx-cluster/fleet' folder"
cd ~/coreos-osx-cluster/fleet
~/coreos-osx-cluster/bin/fleetctl --strict-host-key-checking=false submit fleet-ui.*.service
~/coreos-osx-cluster/bin/fleetctl --strict-host-key-checking=false start fleet-ui.*.service
~/coreos-osx-cluster/bin/fleetctl --strict-host-key-checking=false submit *.service
~/coreos-osx-cluster/bin/fleetctl --strict-host-key-checking=false start *.service
echo "Finished installing fleet units:"
fleetctl list-units
echo " "

echo ""
echo "CoreOS Cluster was reloaded !!!"
echo ""
pause 'Press [Enter] key to continue...'
