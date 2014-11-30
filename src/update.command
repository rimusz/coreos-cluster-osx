#!/bin/bash

#  update.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

function pause(){
read -p "$*"
}

cd ~/coreos-osx-cluster/coreos-vagrant
vagrant box update
vagrant up

# download latest coreos-vagrant
rm -rf ~/coreos-osx-cluster/github
git clone https://github.com/coreos/coreos-vagrant/ ~/coreos-osx-cluster/github
echo "Downloads from github/coreos-vagrant are stored in ~/coreos-osx-cluster/github folder"
echo " "

# download latest versions of etcdctl and fleetctl
cd ~/coreos-osx-cluster/coreos-vagrant
LATEST_RELEASE=$(vagrant ssh core-01 -c "etcdctl --version" | cut -d " " -f 3- | tr -d '\r' )
cd ~/coreos-osx-cluster/bin
echo "Downloading etcdctl $LATEST_RELEASE for OS X"
curl -L -o etcd.zip "https://github.com/coreos/etcd/releases/download/v$LATEST_RELEASE/etcd-v$LATEST_RELEASE-darwin-amd64.zip"
unzip -j -o "etcd.zip" "etcd-v$LATEST_RELEASE-darwin-amd64/etcdctl"
rm -f etcd.zip
echo "etcdctl was copied to ~/coreos-osx-cluster/bin "
#
cd ~/coreos-osx-cluster/coreos-vagrant
LATEST_RELEASE=$(vagrant ssh core-01 -c 'fleetctl version' | cut -d " " -f 3- | tr -d '\r')
cd ~/coreos-osx-cluster/bin
echo "Downloading fleetctl v$LATEST_RELEASE for OS X"
curl -L -o fleet.zip "https://github.com/coreos/fleet/releases/download/v$LATEST_RELEASE/fleet-v$LATEST_RELEASE-darwin-amd64.zip"
unzip -j -o "fleet.zip" "fleet-v$LATEST_RELEASE-darwin-amd64/fleetctl"
rm -f fleet.zip
echo "fleetctl was copied to ~/coreos-osx-cluster/bin "
#
echo "Update has finished !!!"
pause 'Press [Enter] key to continue...'
