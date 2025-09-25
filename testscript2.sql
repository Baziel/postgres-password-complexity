\echo '>>> begin testscript 2 >>>'
--\echo
--\echo
--SELECT * FROM password_check.profiles;
\echo
\echo
\echo '==> FOR DSS 2 ; require group'
\echo '==> should succeed:' 
CREATE ROLE user2 WITH PASSWORD 'InitialP@ssw0rd1!';
\echo '==> should fail not assigned:'
ALTER ROLE user2 WITH PASSWORD 'NewL0ngP@ssw0rd2!';
SELECT pg_sleep(1);
GRANT pci_standard_users TO user2;
\echo '==> should succeed 12 chars has 13 but fails:'
ALTER ROLE user2 WITH PASSWORD 'NewP@ssw0rd2!';
SELECT pg_sleep(1);
\echo '==> it works with 17 chars:' 
ALTER ROLE user2 WITH PASSWORD 'NewL0ngP@ssw0rd2!';
DROP ROLE user2;
\echo
\echo
--SELECT * FROM password_check.profiles;
--\echo
--\echo
\echo '<<< end testscript 2 <<<'
