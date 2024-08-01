#!/bin/bash
set -x
BASE_DIR=$(dirname $(readlink -f $0))
source ${BASE_DIR}/.env

function build_pleroma() {
    cd $BASE_DIR
    export DOCKER_BUILDKIT=1
    docker build -t pleroma . --build-arg PLEROMA_VER=$PLEROMA_VER --build-arg UID=$(id -u) --build-arg GID=$(id -g)
}

build_pleroma
