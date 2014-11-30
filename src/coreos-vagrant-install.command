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

    # download latest coreos-vagrant
    git clone https://github.com/coreos/coreos-vagrant/ ~/coreos-osx-cluster/github

    # cd to App's Resources folder
    cd "$1"

    # copy gsed to ~/coreos-osx-cluster/bin
    cp "$1"/gsed ~/coreos-osx-cluster/bin

    # Vagrantfile
    cp ~/coreos-osx-cluster/github/Vagrantfile ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # chnage VM names to corec-..
    sed -i "" 's/core-%02d/corec-%02d/' ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # change network subnet
    sed -i "" 's/172.17.8.#{i+100}/172.17.9.#{i+100}/g' ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    # change corec-01 host ssh port forward
    cp "$1"/Vagrantfile ~/coreos-osx-cluster/tmp/Vagrantfile
    "$1"/gsed -i "/#config.vm.synced_folder/r $HOME/coreos-osx-cluster/tmp/Vagrantfile" ~/coreos-osx-cluster/coreos-vagrant/Vagrantfile
    rm -f ~/coreos-osx-cluster/tmp/Vagrantfile

    # config.rb file
    # enable discovery setup
    cat "$1"/config.rb ~/coreos-osx-cluster/github/config.rb.sample > ~/coreos-osx-cluster/coreos-vagrant/config.rb
    # set a size of the CoreOS cluster created by Vagrant to 3
    sed -i "" 's/#$num_instances=1/$num_instances=3/' ~/coreos-osx-cluster/coreos-vagrant/config.rb

    # user-data file
    cp ~/coreos-osx-cluster/github/user-data.sample ~/coreos-osx-cluster/coreos-vagrant/user-data

    # initial init
    open -a iTerm.app "$1"/first-init.command
