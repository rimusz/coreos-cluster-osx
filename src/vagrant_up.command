#!/bin/bash

#  vagrant_up.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

cd ~/coreos-osx-cluster/coreos-vagrant
vagrant up

# path to the bin folder where we store our binary files
export PATH=${HOME}/coreos-osx-cluster/bin:$PATH

# set etcd endpoint
export ETCDCTL_PEERS=http://172.17.9.101:4001
echo "etcd cluster:"
etcdctl --no-sync ls /
echo ""

# set fleetctl endpoint
export FLEETCTL_ENDPOINT=http://172.17.9.101:4001
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
echo "fleetctl list-machines:"
fleetctl list-machines
echo ""
# list fleet units
cd ~/coreos-osx-cluster/fleet
fleetctl start fleet-ui.*.service
fleetctl start *.service
echo "fleet units:"
fleetctl list-units
echo " "
cd ~/coreos-osx-cluster

# open bash shell
/bin/bash
