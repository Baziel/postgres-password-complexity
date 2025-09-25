#!/bin/bash
echo '>>> begin testscript 0.6 shell >>>'
echo ' '
echo '==> Should fail contains "Wachtw0ordJ€"'
export PGPASSWORD='Wachtw0ordJ€'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest_bad_pw_user -dpwdb -ec"\conninfo";
export PGPASSWORD='Xbad_pw_user123!'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Ubad_pw_user -dpwdb -ec"\conninfo";
echo '<<< end testscript 0.6 shell <<<'
