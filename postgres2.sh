#!/bin/bash
set -e
echo '>>>> START postgres2.sh <<<<<'
export PGDATA=/pgdata/data
export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/pgsql-17/bin"
export LOGNAME="postgres"
. /var/lib/pgsql/.bash_profile

sleep 5
cd /pgdata/data || exit
echo '>>>> 

                                        NO RULES / VANILLA POSTGRES 

<<<<<'
/usr/pgsql-17/bin/pg_ctl -D /pgdata/data -l logfile start
sleep 5
/usr/pgsql-17/bin/psql -c 'CREATE DATABASE pwdb;'
/usr/pgsql-17/bin/psql -c "CREATE USER test with password 'test'; GRANT ALL on database pwdb to test;"
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -c "CREATE USER test1 with password 't€st'; GRANT ALL on database pwdb to test;"
export PGPASSWORD='t€st'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest1 -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -c 'CREATE USER user1;' 
echo '>>>> NO RULES / VANILLA POSTGRES test <<<<<'
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql

echo '>>>> 

                                        DEFAULT POSTGRES + POSTGRESQL SETTINGS

<<<<<'
cp /tmp/postgresql.conf /pgdata/data/postgresql.conf
/usr/pgsql-17/bin/pg_ctl restart -D /pgdata/data
sleep 5
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo"
echo '>>>> DEFAULT POSTGRES + POSTGRESQL SETTINGS test <<<<<'
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql

echo '>>>> 

                                        DSS VERSION 0.1

<<<<<'
/usr/pgsql-17/bin/psql -c "alter database pwdb SET search_path TO postgres,pwdb,pgtle,password_check;"
cp /tmp/postgresql1.conf /pgdata/data/postgresql.conf
/usr/pgsql-17/bin/pg_ctl restart -D /pgdata/data
sleep 5
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci01_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.1.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci01_behind.sql
echo "'>>>> DSS VERSION 0.1  test <<<<<'"
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql

echo '>>>>

                                        DSS VERSION 0.2

<<<<<'
cp /tmp/postgresql2.conf /pgdata/data/postgresql.conf
/usr/pgsql-17/bin/pg_ctl restart -D /pgdata/data
sleep 5
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci02_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.2_up_0.1-0.2.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci02_behind.sql
/usr/pgsql-17/bin/psql -c "grant pci_standard_users to user1;"
echo '>>>> DSS VERSION 0.2 test <<<<<'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
#usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql

echo '>>>>

                                        DSS VERSION 0.3 password reuse

<<<<<'
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci03_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.3_up_0.2-0.3.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci03_behind.sql
echo '>>>> DSS VERSION 3 password reuse test <<<<<'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript3.sql

echo '>>>>

                                        DSS VERSION 0.4 password timeout

<<<<<'
cp /tmp/postgresql4.conf /pgdata/data/postgresql.conf
/usr/pgsql-17/bin/pg_ctl restart -D /pgdata/data
sleep 5
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci04_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.4_up_0.3-0.4.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci04_behind.sql
/usr/pgsql-17/bin/pg_ctl restart -D /pgdata/data
sleep 5
export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
echo '>>>> DSS VERSION 0.4 password timeout test <<<<<'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript3.sql
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript4.sql
/bin/bash /tmp/testscript4.sh

echo '>>>>

                                        DSS VERSION 0.5 fail after multiple wrong passwords

<<<<'
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci05_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.5_up_0.4-0.5.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci05_behind.sql
echo '>>>> DSS VERSION 0.5 test <<<<<'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript3.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript4.sql
#/bin/bash /tmp/testscript4.sh
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript5.sql
/bin/bash /tmp/testscript5.sh

echo '>>>>

                                        DSS VERSION 0.6 dictionary passwords

<<<<'
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci06_before.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci_password_check_rules_0.6_up_0.5-0.6.sql
/usr/pgsql-17/bin/psql -d pwdb -f /tmp/pci06_behind.sql
echo '>>>> DSS VERSION 0.5 test <<<<<'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript3.sql
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript4.sql
#/bin/bash /tmp/testscript4.sh
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript5.sql
#/bin/bash /tmp/testscript5.sh
/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript6.sql
/bin/bash /tmp/testscript6.sh
