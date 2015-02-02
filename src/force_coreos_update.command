#!/bin/bash

#  force_coreos_update.command
#  CoreOS Cluster for OS X
#
#  Created by Rimantas on 01/04/2014.
#  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.

function pause(){
read -p "$*"
}

cd ~/coreos-osx-cluster/control
vagrant up
vagrant ssh control-01 -c "sudo update_engine_client -update"
echo "Done with control-01 "
echo " "
#
cd ~/coreos-osx-cluster/workers
vagrant ssh node-01 -c "sudo update_engine_client -update"
echo "Done with node-01 "
echo " "
vagrant ssh node-02 -c "sudo update_engine_client -update"
echo "Done with node-02 "
echo " "

echo "Update has finished !!!"
echo "You need to reboot machines if CoreOS update was successful"
echo "Just use 'Reload' from the App menu"
pause 'Press [Enter] key to continue...'
