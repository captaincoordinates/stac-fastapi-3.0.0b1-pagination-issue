#!/bin/bash

versions=("3.0.0a4" "3.0.0b1" "3.0.0b2")
for SFAPI_VERSION in "${versions[@]}"
do
    export SFAPI_VERSION
    docker compose build
    docker compose run --rm tester
    exit_code=$?
    echo; echo "-----------"
    if [ $exit_code -eq 0 ]; then
        echo "# $SFAPI_VERSION success"
    else
        echo "# $SFAPI_VERSION failure"
    fi
    echo "-----------"; echo
done
