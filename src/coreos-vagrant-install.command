#!/bin/bash

#  coreos-vagrant-install.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

    # create "coreos-osx-cluster" and other required folders and files at user's home folder where all the data will be stored
    mkdir ~/coreos-osx-cluster
    mkdir ~/coreos-osx-cluster/coreos-vagrant
    mkdir ~/coreos-osx-cluster/tmp
    mkdir ~/coreos-osx-cluster/bin
    mkdir ~/coreos-osx-cluster/fleet

    # cd to App's Resources folder
    cd "$1"

    # copy fleet units
    cp "$1"/fleet/*.service ~/coreos-osx-cluster/fleet/

    # copy gsed to ~/coreos-osx-cluster/bin
    cp "$1"/gsed ~/coreos-osx-cluster/bin
    chmod 755 ~/coreos-osx-cluster/bin/gsed

    # copy files to ~/coreos-osx-cluster/tmp for later use of first-init.command
    # Vagrantfile
    cp "$1"/Vagrantfile ~/coreos-osx-cluster/tmp/Vagrantfile
    # config.rb file
    cp "$1"/config.rb ~/coreos-osx-cluster/tmp/config.rb
    # user-data
    cp "$1"/user-data ~/coreos-osx-cluster/tmp/user-data

    # initial init
    open -a iTerm.app "$1"/first-init.command
