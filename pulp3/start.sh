#!/bin/bash

#Configure
cp ./pulp/lib/python3.*/site-packages/pulpcore/etc/pulp/server.yaml /etc/pulp/server.yaml
#Vars
CONF_DB_USER=${DB_USER:-pulp}
CONF_DB_PASS=${DB_PASS:-Ch4ng3_ThIs_P4sSW0rd}
CONF_DB_NAME=${DB_NAME:-pulp}
CONF_DB_HOST=${DB_HOST:-db}
CONF_DB_PORT=${DB_PORT:-5432}

cat << EOF >> /etc/pulp/server.yaml

## Docker added config 
databases:
  default:
    CONN_MAX_AGE: 0
    ENGINE: django.db.backends.postgresql_psycopg2
    NAME: ${CONF_DB_NAME}
    USER: ${CONF_DB_USER}
    PASSWORD: ${CONF_DB_PASS}
    HOST: ${CONF_DB_HOST}
    PORT: ${CONF_DB_PORT}

EOF

if [[ "`grep -c "^SECRET_KEY: ." /etc/pulp/server.yaml`" = "0" ]]; then
  echo "WARN: SECRET_KEY not found in config."
  echo "INFO: Generating and Adding secret key to config"
  echo "SECRET_KEY: '$(python3 secret.py)'" >> /etc/pulp/server.yaml
fi

## Keepalive run loop
while :; do
  # Wait for DB
  
  STATUS="down"
  until [ "$STATUS" = "up" ]; do
    echo "Waiting for DB to be ready"
    timeout 3 bash -c "echo >/dev/tcp/${CONF_DB_HOST}/${CONF_DB_PORT}" || false
    if [ $? = 0 ]; then
      echo "INFO: DB is *UP*"
      STATUS="up"
    else
      echo "INFO: DB not available yet. Sleeping"
      sleep 3
    fi
    exec 6>&-
  done

  #Run
  source /pulp/bin/activate && \
  export DJANGO_SETTINGS_MODULE=pulpcore.app.settings && \
  django-admin migrate --noinput auth && \
  django-admin migrate --noinput && \
  django-admin reset-admin-password --password admin && \
  django-admin runserver 80
done
