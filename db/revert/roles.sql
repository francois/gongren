-- Revert roles
SET client_min_messages TO 'warning';

BEGIN;

  ALTER DEFAULT PRIVILEGES FOR ROLE gongren
  IN SCHEMA public
  REVOKE USAGE
  ON SEQUENCES FROM gongrenui;

  ALTER DEFAULT PRIVILEGES FOR ROLE gongren
  IN SCHEMA public
  REVOKE ALL PRIVILEGES
  ON TABLES FROM gongrenui;

  REVOKE CONNECT ON DATABASE gongren FROM gongrenui;
  DROP USER gongrenui;

  ALTER DATABASE gongren OWNER TO sqitch;
  DROP GROUP gongren;

COMMIT;
