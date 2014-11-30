#!/bin/bash

#  first-init.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

### getting files from github and setting them up
    echo ""
    echo "Downloading latest coreos-vagrant files from github: "
    git clone https://github.com/coreos/coreos-vagrant/ ~/coreos-osx-cluster/github
    echo "Done downloading from github !!!"
    echo ""

    # Vagrantfile
    cp ~/coreos-osx-cluster/github/Vagrantfile ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # change VM names to corec-..
    sed -i "" 's/core-%02d/corec-%02d/' ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # change network subnet
    sed -i "" 's/172.17.8.#{i+100}/172.17.9.#{i+100}/g' ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # change corec-01 host ssh port forward
    ~/coreos-osx-cluster/bin/gsed -i "/#config.vm.synced_folder/r $HOME/coreos-osx-cluster/tmp/Vagrantfile" ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    rm -f ~/coreos-osx-cluster/tmp/Vagrantfile

    # config.rb file
    # enable discovery setup
    cat ~/coreos-osx-cluster/tmp/config.rb ~/coreos-osx-cluster/github/config.rb.sample > ~/coreos-osx-cluster/coreos-vagrant/config.rb
    # set a size of the CoreOS cluster created by Vagrant to 3
    sed -i "" 's/#$num_instances=1/$num_instances=3/' ~/coreos-osx-cluster/coreos-vagrant/config.rb
    rm -f ~/coreos-osx-cluster/tmp/config.rb

    # user-data file
    cp ~/coreos-osx-cluster/github/user-data.sample ~/coreos-osx-cluster/coreos-vagrant/user-data
###

### Set release channel
LOOP=1
while [ $LOOP -gt 0 ]
do
    VALID_MAIN=0
    echo " "
    echo "Set CoreOS Release Channel:"
    echo " 1)  Alpha "
    echo " 2)  Beta "
    echo " 3)  Stable "
    echo " "
    echo "Select an option:"

    read RESPONSE
    XX=${RESPONSE:=Y}

    if [ $RESPONSE = 1 ]
    then
        VALID_MAIN=1
        sed -i "" 's/#$update_channel/$update_channel/' ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='stable'/channel='alpha'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='beta'/channel='alpha'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        LOOP=0
    fi

    if [ $RESPONSE = 2 ]
    then
        VALID_MAIN=1
        sed -i "" 's/#$update_channel/$update_channel/' ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='alpha'/channel='beta'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='stable'/channel='beta'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        LOOP=0
    fi

    if [ $RESPONSE = 3 ]
    then
        VALID_MAIN=1
        sed -i "" 's/#$update_channel/$update_channel/' ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='alpha'/channel='stable'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        sed -i "" "s/channel='beta'/channel='stable'/" ~/coreos-osx-cluster/coreos-vagrant/config.rb
        LOOP=0
    fi

    if [ $VALID_MAIN != 1 ]
    then
        continue
    fi
done
### Set release channel

#
function pause(){
read -p "$*"
}

# first up to initialise VMs
echo "Setting up Vagrant VMs for CoreOS Cluster on OS X"
cd ~/coreos-osx-cluster/coreos-vagrant
vagrant box update
vagrant up

# Add vagrant ssh key to ssh-agent
###vagrant ssh-config core-01 | sed -n "s/IdentityFile//gp" | xargs ssh-add
ssh-add ~/.vagrant.d/insecure_private_key

# download etcdctl and fleetctl
#
cd ~/coreos-osx-cluster/coreos-vagrant
LATEST_RELEASE=$(vagrant ssh corec-01 -c "etcdctl --version" | cut -d " " -f 3- | tr -d '\r' )
cd ~/coreos-osx-cluster/bin
echo "Downloading etcdctl $LATEST_RELEASE for OS X"
curl -L -o etcd.zip "https://github.com/coreos/etcd/releases/download/v$LATEST_RELEASE/etcd-v$LATEST_RELEASE-darwin-amd64.zip"
unzip -j -o "etcd.zip" "etcd-v$LATEST_RELEASE-darwin-amd64/etcdctl"
rm -f etcd.zip
#
cd ~/coreos-osx-cluster/coreos-vagrant
LATEST_RELEASE=$(vagrant ssh corec-01 -c 'fleetctl version' | cut -d " " -f 3- | tr -d '\r')
cd ~/coreos-osx-cluster/bin
echo "Downloading fleetctl v$LATEST_RELEASE for OS X"
curl -L -o fleet.zip "https://github.com/coreos/fleet/releases/download/v$LATEST_RELEASE/fleet-v$LATEST_RELEASE-darwin-amd64.zip"
unzip -j -o "fleet.zip" "fleet-v$LATEST_RELEASE-darwin-amd64/fleetctl"
rm -f fleet.zip
# set fleetctl tunnel
export FLEETCTL_TUNNEL=127.0.0.1:2322
export FLEETCTL_STRICT_HOST_KEY_CHECKING=false
echo "fleetctl list-machines :"
fleetctl list-machines
#
echo ""
echo "Installation has finished, CoreOS VMs are up and running !!!"
echo "Enjoy CoreOS-Vagrant Cluster on your Mac !!!"
echo ""
echo "Run from menu 'Up & OS Shell' to open a terninal window preset with fleetctl and etcdctl to cluster settings"
echo ""
pause 'Press [Enter] key to continue...'


