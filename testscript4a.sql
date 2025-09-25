DO
$do$
BEGIN
  EXECUTE format($$ALTER USER expiring_user VALID UNTIL %L$$, NOW() + INTERVAL '12 hours');
END;
$do$;