#!/bin/bash
set -e
cd hey-dba-pgtle-pcidss/ || exit
git pull
cd ..
/bin/vagrant destroy -f; /bin/script -efq vagrant.log -c "/bin/vagrant up"
