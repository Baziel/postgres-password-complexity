\c pwdb
\echo '>>> begin testscript 0.5 SQL >>>'

DO 
$do$
BEGIN
   EXECUTE format($$CREATE USER test_badpw_user WITH PASSWORD 'WorkingP@ssw0rd!' VALID UNTIL  %L$$, now() + interval '10 minutes');
END;
$do$;  
GRANT pci_standard_users TO test_badpw_user;
GRANT ALL ON DATABASE pwdb TO test_badpw_user;
DO
$do$
BEGIN
  EXECUTE format($$ALTER ROLE test_badpw_user VALID UNTIL %L$$, NOW() + INTERVAL '29 days');
END;
$do$; 

DO 
$do$
BEGIN
   EXECUTE format($$CREATE USER test_user WITH PASSWORD 'WorkingP@ssw0rd!' VALID UNTIL  %L$$, now() + interval '10 minutes');
END;
$do$;   
GRANT pci_standard_users TO test_user;
GRANT ALL ON DATABASE pwdb TO test_user;
DO
$do$
BEGIN
  EXECUTE format($$ALTER ROLE test_user VALID UNTIL %L$$, NOW() + INTERVAL '29 days');
END;
$do$; 
\echo '<<< end testscript 0.5 SQL <<<'