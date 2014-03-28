-- Deploy initial-tables
SET client_min_messages TO 'warning';

BEGIN;

  CREATE TABLE locator_roles(
      locator_role text not null
    , primary key(locator_role)
  );

  CREATE TABLE parties(
      party_id serial not null
    , surname text not null check(length(surname) > 0 and trim(surname) = surname)
    , rest_of_name text check(rest_of_name is null or (length(rest_of_name) > 0 and trim(rest_of_name) = rest_of_name))

    , primary key(party_id)
  );

  CREATE TABLE party_passwords(
      party_id int not null references parties
    , crypted_password text not null
    , last_updated_at timestamp with time zone not null

    , primary key(party_id)
  );

  CREATE TABLE party_locators(
      party_id int not null references parties on update cascade on delete cascade
    , locator_role text not null references locator_roles on update cascade on delete restrict
    , valid_starting_on date not null

    , stop_using_on date

    , constraint validity_period_not_null check(stop_using_on is null or (valid_starting_on < stop_using_on))
  );

  CREATE TABLE party_mail_locators(
      address1 text not null check(length(address1) > 0)
    , address2 text not null
    , address3 text not null
    , city text not null check(length(city) > 0)
    , state text not null check(length(state) > 0)
    , zip_or_postal_code text not null check(length(zip_or_postal_code) > 0)

    , primary key(party_id, locator_role, valid_starting_on, address1, address2, address3, city, state, zip_or_postal_code)
    , foreign key(party_id) references parties on update cascade on delete cascade
  ) INHERITS(party_locators);

  CREATE TABLE party_email_locators(
      email text not null check(length(email) > 3)

    , primary key(party_id, locator_role, valid_starting_on, email)
    , foreign key(party_id) references parties on update cascade on delete cascade
  ) INHERITS(party_locators);

  CREATE TABLE party_walk_to_locators(
      address1 text not null check(length(address1) > 0)
    , address2 text not null
    , address3 text not null
    , city text not null check(length(city) > 0)
    , state text not null check(length(state) > 0)
    , zip_or_postal_code text not null check(length(zip_or_postal_code) > 0)

    , primary key(party_id, locator_role, valid_starting_on, address1, address2, address3, city, state, zip_or_postal_code)
    , foreign key(party_id) references parties on update cascade on delete cascade
  ) INHERITS(party_locators);

  CREATE TABLE party_phone_locators(
      "number" text not null check(trim("number") = "number")
    , extension text not null

    , primary key(party_id, locator_role, valid_starting_on, "number", extension)
    , foreign key(party_id) references parties on update cascade on delete cascade
  ) INHERITS(party_locators);

  CREATE TABLE resources(
      resource_code text not null check(length(resource_code) > 0 and trim(resource_code) = resource_code)
    , name text not null
    , description text

    , primary key(resource_code)
  );

  CREATE TABLE resource_prices(
      resource_code text not null references resources on update cascade on delete cascade
    , valid_starting_on date not null
    , unit_price numeric not null
    , unit_interval interval not null check(unit_interval in (interval '1h', interval '1d', interval '1w', interval '1month'))

    , primary key(resource_code, valid_starting_on, unit_price, unit_interval)
    -- invariant: append only
  );

  CREATE TABLE reservations(
      resource_code text not null references resources on update cascade on delete restrict
    , start_at timestamp with time zone not null
    , end_at timestamp with time zone not null

    , party_id int not null references parties on update cascade on delete restrict

    -- how many units of unit_interval are we renting?
    -- this allows us to confirm that the resource is rented for N hours / days / weeks / months
    , units int not null check(units > 0)

    , unit_price numeric not null
    , unit_interval interval not null
    , price_valid_on date not null

    , primary key(resource_code, start_at)
    , foreign key(resource_code, price_valid_on, unit_price, unit_interval) references resource_prices
    , constraint duration_greater_than_zero check(start_at < end_at)
    , constraint duration_is_an_integer check(
        case
        when unit_interval > '1 day' then
          (end_at::date - start_at::date) = units
        else
          ceil(extract(epoch from (end_at - start_at)) / extract(epoch from unit_interval)) = units
        end
      )

    -- TODO: add exclusion constraint
  );

COMMIT;
