-- Verify initial-tables

BEGIN;

  SELECT locator_role FROM locator_roles WHERE false;

  SELECT party_id, surname, rest_of_name FROM parties WHERE false;
  SELECT party_id, crypted_password, last_updated_at FROM party_passwords WHERE false;
  SELECT party_id, locator_role, valid_starting_on, stop_using_on FROM party_locators WHERE false;
  SELECT party_id, locator_role, valid_starting_on, stop_using_on, address1, address2, address3, city, state, zip_or_postal_code FROM party_mail_locators WHERE false;
  SELECT party_id, locator_role, valid_starting_on, stop_using_on, address1, address2, address3, city, state, zip_or_postal_code FROM party_walk_to_locators WHERE false;
  SELECT party_id, locator_role, valid_starting_on, stop_using_on, email FROM party_email_locators WHERE false;
  SELECT party_id, locator_role, valid_starting_on, stop_using_on, "number", extension FROM party_phone_locators WHERE false;

  SELECT resource_code, name, description FROM resources;
  SELECT resource_code, valid_starting_on, unit_price, unit_interval FROM resource_prices;

  SELECT resource_code, start_at, end_at, party_id, units, unit_price, unit_interval, price_valid_on
  FROM reservations
  WHERE false;

ROLLBACK;
