#!/bin/bash

#  coreos-vagrant-install.command
#  CoreOS Cluster for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

# create symbolic link for vagrant to work on OS X 10.11
ln -s /opt/vagrant/bin/vagrant /usr/local/bin/vagrant >/dev/null 2>&1

    # create "coreos-osx-cluster" and other required folders and files at user's home folder where all the data will be stored
    mkdir ~/coreos-osx-cluster
    mkdir ~/coreos-osx-cluster/tmp
    mkdir ~/coreos-osx-cluster/bin
    mkdir ~/coreos-osx-cluster/fleet
    mkdir ~/coreos-osx-cluster/my_fleet
    mkdir -p ~/coreos-osx-cluster/control
    mkdir -p ~/coreos-osx-cluster/workers

    # cd to App's Resources folder
    cd "$1"

    # copy gsed to ~/coreos-osx-cluster/bin
    cp "$1"/gsed ~/coreos-osx-cluster/bin
    chmod 755 ~/coreos-osx-cluster/bin/gsed

    # copy wget with https support to ~/coreos-osx-cluster/bin
    cp "$1"/wget ~/coreos-osx-cluster/bin
    chmod 755 ~/coreos-osx-cluster/bin/wget

    # copy other files
    # user-data files
    cp "$1"/Vagrantfiles/user-data.control ~/coreos-osx-cluster/control/user-data
    cp "$1"/Vagrantfiles/user-data.node ~/coreos-osx-cluster/workers/user-data

    # copy fleet units
    cp -R "$1"/fleet/ ~/coreos-osx-cluster/fleet

    # initial init
    open -a iTerm.app "$1"/first-init.command
