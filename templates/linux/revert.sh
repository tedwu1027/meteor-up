#!/bin/bash

deployment_failed (){
  echo "App did not pick up! Please check app logs." 1>&2
  exit 1
}

set -e

cd /opt/<%= appName %>/

# delete old softlink
sudo rm -rf app
sudo rm -rf config

# create new softlink
sudo ln -s tags/<%= version %>/bundle app
sudo ln -s tags/<%= version %>/config config

#wait and check
echo "Waiting for MongoDB to initialize. (5 minutes)"
. /opt/<%= appName %>/tags/<%= version %>/config/env.sh
wait-for-mongo ${MONGO_URL} 300000

# restart app
sudo stop <%= appName %> || :
sudo start <%= appName %> || :

echo "Waiting for <%= deployCheckWaitTime %> seconds while app is booting up"
sleep <%= deployCheckWaitTime %>

echo "Checking is app booted or not?"
curl localhost:${PORT} || deployment_failed

# chown to support dumping heapdump and etc
sudo chown -R meteoruser app