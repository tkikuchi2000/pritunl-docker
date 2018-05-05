#!/bin/bash

trap_sigterm() {
  echo '============ SIGTERM RECEIVED ============='
  mongod --shutdown && rm -rf /data/db/mongod.lock
  echo '============ MONGODB SHUTDOWN DONE ============='
  sleep 3
  exit 0
}

trap 'trap_sigterm' SIGTERM

if [ -e /data/db/mongod.lock ]; then
  mongod --repair
fi

nohup mongod &

while true; do
  sleep 5
done

#vim: set nu sts=2 et si=2:
