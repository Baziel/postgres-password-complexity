-- Useful queries for verification after update:
--SELECT name, setting, short_desc, context FROM pg_settings WHERE name LIKE 'pgtle%' ORDER BY 1;
--SELECT * FROM pgtle.available_extensions();
--SELECT * FROM pgtle.available_extension_versions();
--SELECT * FROM pgtle.extension_update_paths('pci_password_check_rules');
ALTER EXTENSION pci_password_check_rules UPDATE TO '0.6';
--SELECT pgtle.set_default_version('pci_password_check_rules', '0.5'); -- Example to revert default version
--\dx
