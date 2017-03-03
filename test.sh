#!/bin/bash

set -ex

git clone -b master --depth 1 $CI_BUILD_REPO master
pushd stable
./build.sh
surge --project $PWD/output --domain ntc-docs-${CI_BUILD_REF_NAME}.surge.sh
popd
