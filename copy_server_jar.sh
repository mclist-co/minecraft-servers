#!/bin/bash

export SETUP_ONLY=true
/start
export SETUP_ONLY=false

SERVER=$(find /data -name "*server*.jar")

echo "Server jar found at $SERVER. Copying to /server.jar"

cp $SERVER /server.jar
