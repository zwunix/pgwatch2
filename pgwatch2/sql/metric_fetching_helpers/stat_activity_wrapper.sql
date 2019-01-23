/*
A wrapper around pg_stat_activity to enable session, blocking lock, etc monitoring
by the non-superuser pgwatch2 role.
Assumes a role has been created named pgwatch2
*/


CREATE OR REPLACE FUNCTION get_stat_activity() RETURNS SETOF pg_stat_activity AS
$$
  select * from pg_stat_activity where datname = current_database()
$$ LANGUAGE sql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION get_stat_activity() TO pgwatch2;
COMMENT ON FUNCTION get_stat_activity() IS 'created for pgwatch2';
