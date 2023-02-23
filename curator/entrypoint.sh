#!/bin/sh

set +x

while true; do
  curator --config config.yml action.yml
  sleep 3600
done

