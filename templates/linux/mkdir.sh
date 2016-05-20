#!/bin/bash

cd /opt/<%= appName %>/

# check if tags directory exists
if [ ! -d tags/<%= version %>/config ]; then
  sudo mkdir -p tags/<%= version %>/config
fi