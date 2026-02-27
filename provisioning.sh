#!/bin/bash
set -e
echo START provisioning.sh
if [ -f ../provisioning_private.sh ]; then
	echo "../provisioning_private.sh"
	. ../provisioning_private.sh
fi

if [ -f ../provisioning_default.sh ]; then
	echo "../provisioning_default.sh"
	. ../provisioning_default.sh
fi

timedatectl set-timezone Europe/Amsterdam


groupadd postgres --gid 26
groupadd barman --gid 426
adduser postgres --uid 26 --gid 26
adduser barman --uid 426 --gid 426

echo "postgres ALL=(ALL) NOPASSWD: ALL">/etc/sudoers.d/postgres

sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-10-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo dnf -qy module disable postgresql
sudo dnf install -y postgresql17-contrib
sudo dnf install -y postgresql17-server

systemctl enable postgresql-17.service
mkdir -p /etc/systemd/system/postgresql-17.service.d/
cp /tmp/systemctloverride /etc/systemd/system/postgresql-17.service.d/override.conf
systemctl daemon-reload

#mkdir -p /media/samba/qnap/Backup/database/server8/postgres/postgres17
#chown -R barman:barman /media/samba/qnap/Backup/database/server8

#curl https://dl.2ndquadrant.com/default/release/get/13/rpm | sudo bash
#dnf -y install barman-3.14.0*
#cp -p /tmp/barman.conf /etc/barman.conf
#cp -p /tmp/server6-postgres17.conf /etc/barman.d/server6-postgres17.conf
#sudo chown barman:barman /etc/barman.conf
#sudo chown barman:barman /etc/barman.d/*
#sudo cp /tmp/logrotate_barman /etc/logrotate.d/logrotate_barman
#sudo cp /tmp/backup_barman /etc/cron.daily/backup_barman
#sudo -u barman barman receive-wal --create-slot server6

dnf -y install pg_tle_17

mkdir /pgdata
mkdir /pgdata/data
chown -R postgres:postgres /pgdata

cat 

sudo -u postgres /tmp/postgres.sh
sleep 10
cp /tmp/pg_hba.conf /pgdata/data/pg_hba.conf
systemctl enable postgresql-17
systemctl restart postgresql-17
sleep 10
systemctl stop postgresql-17
sleep 10
sudo -u postgres /tmp/postgres2.sh
