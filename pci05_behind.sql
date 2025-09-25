
-- The following ALTER SYSTEM commands are examples for configuration and require manual execution
-- outside of the update path script, typically after the extension update is applied.

--ALTER SYSTEM SET pgtle.clientauth_users_to_skip TO 'postgres';
--SELECT pg_catalog.pg_reload_conf();
--
-- ALTER SYSTEM SET pgtle.enable_clientauth TO 'on';
-- IMPORTANT: This setting requires a database restart to take full effect.
-- Context: SIGHUP. Note: A database restart is needed to enable the clientauth feature, i.e. to switch from off to on or require


-- Useful queries for verification after update:
ALTER EXTENSION pci_password_check_rules UPDATE TO '0.5';
--SELECT name, setting, short_desc, context FROM pg_settings WHERE name LIKE 'pgtle%' ORDER BY 1;
--SELECT * FROM pgtle.available_extensions();
--SELECT * FROM pgtle.available_extension_versions();
--SELECT * FROM pgtle.extension_update_paths('pci_password_check_rules');
--SELECT pgtle.set_default_version('pci_password_check_rules', '0.4'); -- Example to revert default version
-- To list installed extensions and their versions
--\dx


