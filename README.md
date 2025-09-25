postgres-password-complexity

The logfile from the last time I ran this before pushing is in vagrant.log and is readable in technicolor(tm) via less -R vagrant.log

You will need to set up vagrant & virtualbox in order to have the same run I did and you will need to change the Vagrantfile to setup your network environment.
the database is in /pgdata/data, and may need to be set up differently if needed.

Huge thanks to Evandro from hey-dba for the code and the help.
This is all based on his code, check out:

https://hey-dba.com/articles/postgresql/the-epic-quest-for-secure-passwords-a-postgresql-pci-dss-saga/

There is a video of a run in

https://www.youtube.com/watch?v=Ce8w76BWkRY

takes 5 minutes, it starts to get postgressy from 3 minutes. No need to share, patreon, subscribe, or hit bells.


