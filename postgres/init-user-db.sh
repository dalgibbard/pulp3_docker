#!/bin/bash
set -e
psql --username postgres -v ON_ERROR_STOP=1 <<-EOSQL
    CREATE USER ${PULP_DB_USER} with PASSWORD 'AnyPass';
    CREATE DATABASE ${PULP_DB};
    GRANT ALL PRIVILEGES ON DATABASE ${PULP_DB} TO ${PULP_DB_USER};
EOSQL

echo "ALTER USER ${PULP_DB_USER} WITH PASSWORD '${PULP_DB_PASS}';" | psql --username postgres
