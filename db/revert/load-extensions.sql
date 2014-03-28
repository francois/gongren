-- Revert load-extensions
SET client_min_messages TO 'warning';

BEGIN;

  DROP EXTENSION IF EXISTS pgcrypto;
  DROP EXTENSION IF EXISTS "uuid-ossp";
  DROP EXTENSION IF EXISTS "tablefunc";
  DROP EXTENSION IF EXISTS btree_gist;

COMMIT;
