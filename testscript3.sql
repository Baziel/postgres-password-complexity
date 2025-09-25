\echo '>>> begin testscript 3 >>>'
\echo >>> FOR DSS 3 ; password reuse<<<<
\echo '==> first 4 should succeed:'
CREATE ROLE user3 WITH PASSWORD 'StrongP@ssw0rd1!';
GRANT pci_standard_users TO user3;
ALTER ROLE user3 WITH PASSWORD 'V3ryStr0ngP@ssw0rd2!';
ALTER ROLE user3 WITH PASSWORD 'Sup3rDuperP@ssw0rd3!';
ALTER ROLE user3 WITH PASSWORD 'Ult1mateP@ssw0rd4!';
\echo '==> should fail, reused:'
ALTER ROLE user3 WITH PASSWORD 'StrongP@ssw0rd1!';
SELECT pg_sleep(1);
\echo '==> should fail, reused:'
ALTER ROLE user3 WITH PASSWORD 'V3ryStr0ngP@ssw0rd2!';
SELECT pg_sleep(1);
\echo '==> should succeed,new password:' 
ALTER ROLE user3 WITH PASSWORD 'TotallyN3wP@ssw0rd5!';
DROP ROLE user3;
DELETE FROM password_check.password_history where username='user3';
\echo '<<< end testscript 3 <<<'