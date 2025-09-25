\echo '>>> begin testscript 1 >>>'
\echo '==> Different passwords that need to fail DSS 1<<<'
ALTER USER user1 PASSWORD 'Short@1';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'nocapitals@1';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'NotEnoughNumbers_@';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'NOLOWERCASE@1';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'NoSpecialChars1';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'verywrong';
SELECT pg_sleep(1);
\echo 
\echo '==> This one should work:'
ALTER USER user1 PASSWORD 'V@l1dP4ssW0rd!';
SELECT pg_sleep(1);
\echo '<<< end testscript 1 <<<'
