\c pwdb;
--\dx;
ALTER SYSTEM SET pgtle.passcheck_db_name TO 'pwdb';
SELECT pg_catalog.pg_reload_conf();
ALTER SYSTEM SET pgtle.enable_password_check TO 'on';
SELECT pg_catalog.pg_reload_conf();
--\dn;