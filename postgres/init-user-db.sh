#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 <<-EOSQL
    CREATE USER ${PULP_USER} with PASSWORD '${PULP_PASS}';
    CREATE DATABASE ${PULP_DB};
    GRANT ALL PRIVILEGES ON DATABASE ${PULP_DB} TO ${PULP_USER};
EOSQL