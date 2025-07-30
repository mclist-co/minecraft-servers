#!/bin/bash

function obtain_via_start_command() {
  echo "Running /start to obtain server jar..."

  while [ 1 ]; do
    export SETUP_ONLY=true
    /start
    export SETUP_ONLY=false

    SERVER=$(find /data -name "*.jar")

    if [ -n "$SERVER" ]; then
      echo "Found server jar: $SERVER"
    fi

    if [ -z "$SERVER" ]; then
      echo "No server jar found in /data. Listing contents:"
      ls /data
      echo "Server jar not found. Retrying in 5 seconds..."
      sleep 5
    else
      break
    fi
  done

  echo "Server jar found at $SERVER. Copying to /server.jar"

  cp $SERVER /server.jar
}

function obtain_via_buildtools() {
  echo "Running BuildTools to obtain server jar..."

  if [ ! -f /BuildTools.jar ]; then
    echo "BuildTools.jar not found. Exiting."
    exit 1
  fi

  java -jar /BuildTools.jar --rev $VERSION --compile $TYPE --final-name server.jar

  SERVER="/data/server.jar"

  if [ -z "$SERVER" ]; then
    echo "No server jar found after running BuildTools. Exiting."
    exit 1
  fi

  echo "Server jar found at $SERVER. Copying to /server.jar"
  cp $SERVER /server.jar
}

# when spigot or bukkit use buildtools
if [[ "$TYPE" == "spigot" || "$TYPE" == "bukkit" ]]; then
  obtain_via_buildtools
  exit 0
fi

obtain_via_start_command
