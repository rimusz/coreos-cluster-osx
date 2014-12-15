CoreOS-Vagrant Cluster GUI for OS X
============================

CoreOS-Vagrant Cluster GUI for Mac OS X is a Mac Status bar App which works like a wrapper around the [coreos-vagrant](https://github.com/coreos/coreos-vagrant) command line tool and supports 3 cluster machines. A standalone one can be found here [CoreOS-Vagrant GUI](https://github.com/rimusz/coreos-osx-gui).
 
[CoreOS](https://coreos.com) is a Linux distribution made specifically to run [Docker](https://www.docker.io/) containers.
[CoreOS-Vagrant](https://github.com/coreos/coreos-vagrant) is made to run on VirtualBox and VMWare VMs.

![CoreOS-Vagrant-Cluster-GUI](coreos-vagrant-cluster-gui.png "CoreOS-Vagrant-Cluster-GUI")

Download
--------
Head over to the [Releases Page](https://github.com/rimusz/coreos-osx-gui-cluster/releases) to grab the latest ZIP file.


How to install
----------

Required software
* [VirtualBox for Mac OS X hosts](https://www.virtualbox.org/wiki/Downloads), [Vagrant for Mac OS X](http://www.vagrantup.com/downloads.html) and [iTerm 2](http://www.iterm2.com/#/section/downloads)
* It best works with Vagrant 1.6.x, but on 1.7.x it might have problems with fleetctl as of v1.7, Vagrant splats a random SSH key on each VM.
* Download `CoreOS Cluster GUI latest.zip` from the [Releases Page](https://github.com/rimusz/coreos-osx-gui-cluster/releases) and unzip it.
* Start the `CoreOS Cluster GUI` and from menu `Setup` choose `Initial setup of CoreOS-Vagrant Cluster` 
* The install will do the following:
````
1) All dependent files/folders will be put under 'coreos-osx-cluster' folder in the user's 
 home folder e.g '/Users/someuser/coreos-osx-cluster'
2) Will clone latest coreos-vagrant from git
3) user-data file will have fleet and etcd set
4) 3 cluster nodes will be set with IPs: '172.17.9.100, 172.17.9.101 and 172.17.9.102'
5) Will download and install fleetctl and etcdctl clients to ~/coreos-osx-cluster/bin/
6) Will download latest vagrant VBox and run vagrant up to initialise VM
8) Will forward port 2322 from localhost to corec-01 ssh port 22.
````

How it works
------------

Just start `CoreOS Cluster GUI` application and you will find a small icon with the CoreOS logo with the (C) which means for cluster in the Status Bar.

* There you can `Up`, `Suspend`, `Halt`, `Reload` CoreOS vagrant VMs
* Under `Up & OS shell` OS Shell will be opened when `vagrant up` finishes and it will have such environment set:
````
1) etcd discovery token will be automaticly replaced from 'https://discovery.etcd.io/new' 
on each 'vagrant up'
2) Path to ~/coreos-osx-cluster/bin where etcdclt and fleetctl binaries are stored
3) FLEETCTL_TUNNEL=127.0.0.1:2322 for the fleetctl tunnel to work properly
````

* `Updates/Force CoreOS update` will be run `sudo update_engine_client -update` on each CoreOS VM.
* `Updates/Check for updates` will update etcdclt and fleetctl OS X clients to the same versions as CoreOS VMs run. It will store downloads from github `coreos-vagrant` in `~/coreos-osx-cluster/github` folder, it will not overwrite user's `Vagrantfile, config.rb and users-data` files.
* `SSH to corec-01/02/03` menu options will open VM shells


Other links
-----------
* A standalone CoreOS VM version App can be found here [CoreOS-Vagrant GUI](https://github.com/rimusz/coreos-osx-gui).

* Also you might like my other [boot2docker GUI for OS X](https://github.com/rimusz/boot2docker-gui-osx) project for [boot2docker](https://github.com/boot2docker/boot2docker).

