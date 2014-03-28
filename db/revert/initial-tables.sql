-- Revert initial-tables
SET client_min_messages TO 'warning';

BEGIN;

  DROP TABLE parties CASCADE;
  DROP TABLE party_locators CASCADE;
  DROP TABLE locator_roles CASCADE;
  DROP TABLE resources CASCADE;
  DROP TABLE reservations CASCADE;
  DROP TABLE resource_prices CASCADE;

COMMIT;
