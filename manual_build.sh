#!/bin/bash
set -x

BASEPATH=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
idadir="${@: -1}"

if [[ "$idadir" != "" ]]; then
    cd "$idadir"
fi

tmpDockerfile=$(mktemp "/tmp/$(basename ${BASH_SOURCE[0]}).Dockerfile-XXXXXXXXXX")
sed 's/--security=insecure //' $BASEPATH/Dockerfile > $tmpDockerfile

DOCKER_BUILDKIT=0 docker build -f $tmpDockerfile "${@: 1:${#@}-1}" .