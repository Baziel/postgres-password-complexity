#!/bin/bash
cd hey-dba-pgtle-pcidss/
git pull
cd ..
/bin/vagrant destroy -f; /bin/script -efq vagrant.log -c "/bin/vagrant up"
