#!/bin/bash

#  coreos-vagrant.command
#  CoreOS Cluster for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.


# pass first argument - up, halt ...
cd ~/coreos-osx-cluster/control
vagrant $1

cd ~/coreos-osx-cluster/workers
vagrant $1
