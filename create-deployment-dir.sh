#!/bin/bash
BASE_DIR=$(dirname $(readlink -f $0))

if [ -z "$1" ]; then
    echo "usage: $0 destination_dir"
    exit
fi

export DIST_PLEROMA=$1

# set -e

if [ -e $DIST_PLEROMA ]; then
    echo "directory $DIST_PLEROMA already exists"
    exit 1
fi

mkdir -p ${DIST_PLEROMA}/deployment

DEPLOYMENT_FILES=".env setenv.sh build-pleroma-docker.sh Dockerfile docker-compose.yml README.md"

for f in $DEPLOYMENT_FILES; do
    cp -v $f ${DIST_PLEROMA}/deployment
done   

mkdir -v -p ${DIST_PLEROMA}/storage/{web,db,config}

cp -v config.exs ${DIST_PLEROMA}/storage/config
chmod 640 ${DIST_PLEROMA}/storage/config/config.exs
