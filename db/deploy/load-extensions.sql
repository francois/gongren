-- Deploy load-extensions
SET client_min_messages TO 'warning';

BEGIN;

  CREATE EXTENSION btree_gist;
  CREATE EXTENSION tablefunc;
  CREATE EXTENSION "uuid-ossp";
  CREATE EXTENSION pgcrypto;

COMMIT;
