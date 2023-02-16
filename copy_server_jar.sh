#!/bin/bash

while [ 1 ]; do
  export SETUP_ONLY=true
  /start
  export SETUP_ONLY=false

  SERVER=$(find /data -name "*server*.jar")

  if [ -z "$SERVER" ]; then
    echo "Server jar not found. Retrying in 5 seconds..."
    sleep 5
  else
    break
  fi
done


echo "Server jar found at $SERVER. Copying to /server.jar"

cp $SERVER /server.jar
