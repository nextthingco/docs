#!/bin/bash

set -ex

export TEST_BRANCH=stable

CI_BUILD_REPO=${CI_BUILD_REPO:?cannot be empty}
CI_BUILD_REF_NAME=${CI_BUILD_REF_NAME:?cannot be empty}
TEST_BRANCH=${TEST_BRANCH:?cannot be empty}

git clone -b $TEST_BRANCH --depth 1 $CI_BUILD_REPO $TEST_BRANCH
pushd $TEST_BRANCH
./build.sh
surge --project $PWD/output --domain ntc-docs-${CI_BUILD_REF_NAME}.surge.sh
popd
