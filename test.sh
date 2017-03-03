#!/bin/bash

set -ex

TEST_BRANCH=stable

git clone -b $TEST_BRANCH --depth 1 $CI_BUILD_REPO $TEST_BRANCH
pushd $TEST_BRANCH
./build.sh
surge --project $PWD/output --domain ntc-docs-${CI_BUILD_REF_NAME}.surge.sh
popd
