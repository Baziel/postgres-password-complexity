#!/bin/bash
echo '>>> begin testscript 0.6 shell >>>'
echo ' '
echo '==> Should fail contains "wachtwoordJ€123"'
export PGPASSWORD='wachtwoordJ€123'; /usr/pgsql-17/bin/psql -h127.0.0.1 -Utest_bad_pw_user -dpwdb -ec"\conninfo";

echo '<<< end testscript 0.6 shell <<<'
