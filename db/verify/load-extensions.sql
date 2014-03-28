-- Verify load-extensions
SET client_min_messages TO 'warning';

BEGIN;

  SELECT 1/count(*) FROM pg_extension WHERE extname = 'tablefunc';
  SELECT has_function_privilege('crosstab(text, text)', 'execute');

  SELECT 1/count(*) FROM pg_extension WHERE extname = 'uuid-ossp';
  SELECT has_function_privilege('uuid_generate_v4()', 'execute');

  SELECT 1/count(*) FROM pg_extension WHERE extname = 'pgcrypto';
  SELECT has_function_privilege('crypt(text, text)', 'execute');
  SELECT has_function_privilege('gen_salt(text)', 'execute');

ROLLBACK;
