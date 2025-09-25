\echo '>>> begin testscript >>>'
\echo '==> Different passwords that ideally should fail, or not enough'
ALTER USER user1 PASSWORD '123';-- too short
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD '123456789'; -- just numbers
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'user1'; --username as password
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'user1user1'; --username as password twice
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'Hello123456789';-- no special characters
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'Hello123456';-- no special characters and too short
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'He123456'; -- too short, no special characters
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'He123456789';-- no special characters
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'He@123456789';
SELECT pg_sleep(1);
ALTER USER user1 PASSWORD 'Hello@123456';
SELECT pg_sleep(1);
\echo '<<< end testscript <<<'