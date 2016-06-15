#!/bin/bash

cd /opt/<%= appName %>/

# check if tags directory exists
if [ ! -d tags/<%= version %>/config ]; then
  LOGGED_USER=$(whoami)
  sudo mkdir -p tags/<%= version %>/config
  sudo chown -R ${LOGGED_USER} tags
fi