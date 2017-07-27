#!/bin/bash
if [ "$1" = "start" ]; then
  set -x
  docker-compose up --build
  set +x
elif [ "$1" = "daemon" ]; then
  set -x
  docker-compose up --build -d
  set +x
elif [ "$1" = "stop" ]; then
  set -x
  docker-compose stop
  set +x
elif [ "$1" = "clean" ]; then
  set -x
  docker-compose stop
  rm -rf data/*
  set +x
else
  echo "Usage: $0 [start|daemon|stop|clean]"
  exit 0
fi
