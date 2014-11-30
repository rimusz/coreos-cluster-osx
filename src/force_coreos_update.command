#!/bin/bash

#  force_coreos_update.command
#  CoreOS Cluster GUI for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

function pause(){
read -p "$*"
}

cd ~/coreos-osx-cluster/coreos-vagrant
vagrant up
vagrant ssh corec-01 -c "sudo update_engine_client -update"
echo "Done with corec-01 "
echo " "
vagrant ssh corec-02 -c "sudo update_engine_client -update"
echo "Done with corec-02 "
echo " "
vagrant ssh corec-03 -c "sudo update_engine_client -update"
echo "Done with corec-03 "
echo " "

echo "Update has finished !!!"
pause 'Press [Enter] key to continue...'
