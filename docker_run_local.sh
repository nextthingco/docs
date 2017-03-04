#!/bin/bash

docker run --rm -it -v $PWD:/share -w /share ntc-docs-builder ./build.sh
