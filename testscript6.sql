\echo\echo '>>> begin testscript 0.6 SQL >>>'
\echo 
\echo '==> Add bad password "Wachtw0ordJ€":'
SELECT password_check.add_bad_password('Wachtw0ordJ€');
\echo 
\echo '==> should fail for many reasons:'
CREATE USER test_bad_pw_user WITH PASSWORD 'Wachtw0ordJ€';
SELECT pg_sleep(1);


\echo 
\echo '==> Now see if we can get it too just not work because the easy password Wachtw0ordJ€:'
DO
$do$
BEGIN
  EXECUTE format($$CREATE USER test_bad_pw_user WITH PASSWORD 'Wachtw0ordJ€' VALID UNTIL %L$$, NOW() + INTERVAL '10 minutes');
END;
$do$;

GRANT pci_admin_users TO test_bad_pw_user;
GRANT ALL ON DATABASE pwdb TO test_bad_pw_user;
DO
$do$
BEGIN
  EXECUTE format($$ALTER ROLE test_bad_pw_user VALID UNTIL %L$$, NOW() + INTERVAL '29 days');
END;
$do$;
SELECT pg_sleep(1);

\echo '<<< end testscript 0.6 SQL <<<'
