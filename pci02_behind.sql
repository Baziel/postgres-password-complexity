ALTER EXTENSION pci_password_check_rules UPDATE TO '0.2';
--SELECT * FROM pgtle.available_extensions();
--SELECT * FROM pgtle.available_extension_versions();
--SELECT * FROM pgtle.extension_update_paths('pci_password_check_rules');
ALTER DATABASE pwdb SET search_path TO postgres,pwdb,pgtle,password_check;
--\dx;
--\dn;
