#!/bin/bash
echo '>>>> begin testscript 0.5 shell part >>>>'
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript.sql 2>&1
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript1.sql 2>&1
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript2.sql 2>&1
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript3.sql 2>&1
#/usr/pgsql-17/bin/psql -d pwdb -ef /tmp/testscript4.sql 2>&1
echo '>>>> begin testscript 0.5 testcase 1>>>>'
#echo '==> should work, because pgtle.clientauth_users_to_skip = "postgres,test,test1,working_user" and does:'
#export PGPASSWORD='G00dL0NgPassw0rd€'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Uworking_user -ec"\conninfo"
echo '==> Should work:'
export PGPASSWORD='WorkingP@ssw0rd!'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
sleep 1;
echo '==> Try bad password 11 times should be locked after 10'
echo '==> Should fail 5 times (=5):'
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
echo ''
echo '==> See failed_attempts go up:'
/usr/pgsql-17/bin/psql -dpwdb -ec"select username, failed_attempts, to_char(last_successful_login , 'YYYY-MM-DD HH24:MI:SS') as last_successful_login , to_char(last_activity, 'YYYY-MM-DD HH24:MI:SS') as last_activity from password_check.user_login_activity where username='test_badpw_user';"
echo ''
echo '==> Should fail 4 more times (=9):'
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
echo ''
echo '==> See failed_attempts go up:'
 /usr/pgsql-17/bin/psql -dpwdb -ec"select username, failed_attempts, to_char(last_successful_login , 'YYYY-MM-DD HH24:MI:SS') as last_successful_login , to_char(last_activity, 'YYYY-MM-DD HH24:MI:SS') as last_activity from password_check.user_login_activity where username='test_badpw_user';"
echo '==> Should fail 1 more time (=10):'
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
echo ''
echo '==> OOPS!:'
echo ''
export PGPASSWORD='BAD_N0GOoD_€vil'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
sleep 1;
echo ''
echo '==> Should be locked now even with correct password:'
export PGPASSWORD='WorkingP@ssw0rd!'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
sleep 1;
echo ''
/usr/pgsql-17/bin/psql -dpwdb -ec"select username, to_char(locked_until , 'YYYY-MM-DD HH24:MI:SS') as locked_until, locked_by from password_check.locked_accounts;"
echo ''
echo '==> Remove from locked accounts:'
/usr/pgsql-17/bin/psql -dpwdb -ec"delete from password_check.locked_accounts where username='test_badpw_user';"
echo ''
echo '==> and try again, should work:'
export PGPASSWORD='WorkingP@ssw0rd!'; /usr/pgsql-17/bin/psql -h127.0.0.1 -dpwdb -Utest_badpw_user -ec"\conninfo";
echo ''
echo ''
echo ">>>> begin testscript 0.5 testcase 2 After a successful login, are the correct profile policies selected? >>>>"
export PGPASSWORD='WorkingP@ssw0rd!'; /usr/bin/nohup /usr/pgsql-17/bin/psql -h127.0.0.1 -d pwdb -Utest_user &
/usr/pgsql-17/bin/psql -dpwdb -ec"select * from password_check.v_role_members_parameters where username='test_user';"

echo '<<<< end testscript 0.5 shell part <<<<'