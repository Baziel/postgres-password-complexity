#!/bin/bash
echo '>>> start testscript 0.4 shell part >>>'
#echo '==> should work, because pgtle.clientauth_users_to_skip = "postgres,test,test1,working_user"  and does:'
#export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
#export PGPASSWORD='t€st'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest1 -dpwdb -ec"\conninfo";
#export PGPASSWORD='G00dL0NgPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Uworking_user -ec"\conninfo"
echo '==> should work:'
export PGPASSWORD='G00dL0NgPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Uworking_user -ec"\conninfo"
sleep 1
echo ''
echo ''
echo '==> should work(expiring_user before expiry):'
export PGPASSWORD='ExpiringPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1  -dpwdb -Uexpiring_user -ec"\conninfo"
echo '>>>> sleep 1 minute for expiry test <<<<'
sleep 60
echo '==> should NOT work , (expiring_user password no longer valid):'
export PGPASSWORD='ExpiringPassw0rd'; /usr/pgsql-17/bin/psql -h127.0.0.1  -dpwdb -Uexpiring_user -ec"\conninfo"
sleep 1
echo '==> change password and reset expiry time:'
/usr/pgsql-17/bin/psql -ec"ALTER USER expiring_user WITH PASSWORD 'NewValidPassw0rd€';"
/usr/pgsql-17/bin/psql -dpwdb -ef "/tmp/testscript4a.sql"
echo ''
echo '==> should work again: (expiring_user new password):'
export PGPASSWORD='NewValidPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1  -dpwdb -Uexpiring_user -ec"\conninfo"
sleep 1
echo ''
echo ''
#echo '==> should work, because pgtle.clientauth_users_to_skip = "postgres,test,test1,working_user"  and does:'
#export PGPASSWORD='test'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest -dpwdb -ec"\conninfo";
#export PGPASSWORD='t€st'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest1 -dpwdb -ec"\conninfo";
#export PGPASSWORD='G00dL0NgPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Uworking_user -ec"\conninfo"
/usr/pgsql-17/bin/psql -dpwdb -c "SELECT username, to_char(change_timestamp, 'YYYY-MM-DD HH24:MI:SS') as change_timestamp, to_char(valid_until, 'YYYY-MM-DD HH24:MI:SS') as valid_until, to_char( now(), 'YYYY-MM-DD HH24:MI:SS') as NOW FROM password_check.password_history;"
echo '<<< end testscript 0.4 shell part <<<'