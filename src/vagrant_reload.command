#!/bin/bash

#  vagrant_up.command
#  CoreOS Cluster for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

function pause(){
read -p "$*"
}

cd ~/coreos-osx-cluster/control
vagrant reload
#
cd ~/coreos-osx-cluster/workers
vagrant reload

# path to the bin folder where we store our binary files
export PATH=${HOME}/coreos-osx-cluster/bin:$PATH

# set etcd endpoint
export ETCDCTL_PEERS=http://172.17.9.101:2379
export FLEETCTL_DRIVER=etcd
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
echo "etcd cluster:"
etcdctl --no-sync ls / --recursive
echo " "

# set fleetctl endpoint
export FLEETCTL_ENDPOINT=http://172.17.9.101:2379
echo "fleetctl list-machines :"
fleetctl list-machines
echo " "
echo "fleetctl list-units:"
fleetctl list-units
echo " "

echo " "
echo "CoreOS Cluster was reloaded !!!"
echo " "
pause 'Press [Enter] key to continue...'
