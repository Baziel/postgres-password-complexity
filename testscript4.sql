\echo '>>> begin testscript 0.4 SQL >>>'
\c pwdb
--SELECT * FROM password_check.password_history;
--SELECT * FROM pgtle.available_extensions();

-- Check all available versions for your extension
--SELECT * FROM pgtle.available_extension_versions();

-- Check the update paths defined for your specific extension
--SELECT * FROM pgtle.extension_update_paths('pci_password_check_rules');

-- Verify the new max_validity_interval column was added to profiles
--\echo '>>>>> password_check.profiles <<<<<'
--SELECT * FROM password_check.profiles;

-- Verify the valid_until column was added to password_history and is NOT NULL
--SELECT username, password_hash, change_timestamp, valid_until FROM password_check.password_history LIMIT 5;

-- Verify clientauth is enabled and postgres is skipped
--SELECT name, setting, short_desc, context FROM pg_settings WHERE name LIKE 'pgtle%';


CREATE ROLE pci_new_users WITH LOGIN;
GRANT CONNECT ON DATABASE pwdb TO pci_new_users;
ALTER ROLE pci_admin_users WITH LOGIN;
GRANT CONNECT ON DATABASE pwdb TO pci_admin_users;
ALTER USER pci_admin_users WITH SUPERUSER;
ALTER ROLE pci_standard_users WITH LOGIN;
GRANT CONNECT ON DATABASE pwdb TO pci_standard_users;
ALTER ROLE pci_app_users WITH LOGIN;
GRANT CONNECT ON DATABASE pwdb TO pci_app_users;

UPDATE password_check.profiles SET max_validity_interval = '1 day' WHERE role = 'pci_standard_users';
-- For pci_app_users, you might set it to '1 year'
UPDATE password_check.profiles SET max_validity_interval = '1 year' WHERE role = 'pci_app_users';
\echo 
\echo '==> should fail: too long in the future:'
DO 
$do$
BEGIN
  EXECUTE format($$CREATE USER test_Too_Ahead_user WITH PASSWORD 'CompliantPassw0rd€' VALID UNTIL %L$$, NOW() + INTERVAL '30 days');
END;
$do$;
SELECT pg_sleep(1);
\echo 
\echo '==> should fail: no valid until null'
CREATE ROLE test_null_user WITH PASSWORD 'NullPassw0rd^';
SELECT pg_sleep(1);

\echo
\echo '==> should work like this: (10 minutes):'
DO 
$do$
BEGIN
  EXECUTE format($$CREATE USER compliant_user WITH PASSWORD 'CompliantPassw0rd€' VALID UNTIL %L$$, NOW() + INTERVAL '10 minutes');
END;
$do$;
\echo
\echo
--SELECT username, password_hash, change_timestamp, valid_until FROM password_check.password_history WHERE USERNAME='compliant_user';
GRANT pci_standard_users TO compliant_user;
GRANT ALL ON DATABASE pwdb TO compliant_user;
--SELECT username, password_hash, change_timestamp, valid_until FROM password_check.password_history WHERE USERNAME='compliant_user';

\echo '>> password_check.profiles <<'
SELECT * FROM password_check.profiles;
UPDATE password_check.profiles SET max_validity_interval = '1 day' WHERE role = 'pci_standard_users';
-- For pci_app_users, you might set it to '1 year'
UPDATE password_check.profiles SET max_validity_interval = '1 year' WHERE role = 'pci_app_users';

--\echo >> password_check.profiles <<
--SELECT * FROM password_check.profiles;

DO
$do$
BEGIN
  EXECUTE format($$CREATE USER working_user WITH PASSWORD 'G00dL0NgPassw0rd€' VALID UNTIL %L$$, NOW() + INTERVAL '10 minutes');
END;
$do$;

GRANT pci_admin_users TO working_user;
GRANT ALL ON DATABASE pwdb TO working_user;
DO
$do$
BEGIN
  EXECUTE format($$ALTER ROLE working_user VALID UNTIL %L$$, NOW() + INTERVAL '29 days');
END;
$do$;

SELECT username, to_char(change_timestamp, 'YYYY-MM-DD HH24:MI:SS') as change_timestamp, to_char(valid_until, 'YYYY-MM-DD HH24:MI:SS') as valid_until, to_char( now(), 'YYYY-MM-DD HH24:MI:SS') as NOW FROM password_check.password_history WHERE USERNAME like '%orking_user';

DO
$do$
BEGIN
  EXECUTE format($$CREATE USER expiring_user WITH PASSWORD 'ExpiringPassw0rd€' VALID UNTIL %L$$, NOW() + INTERVAL '1 minute');
END;
$do$;

GRANT pci_standard_users TO expiring_user;
GRANT ALL ON DATABASE pwdb TO expiring_user;
\echo '<<< end testscript 0.4 SQL <<<'
