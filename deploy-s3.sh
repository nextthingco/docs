#!/bin/bash

set -e
set -x

#NOTE: no pushd here!

export OUTPUT_DIR="${PWD}/output"

# login aws cli
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?not set}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?not set}
export AWS_DEFAULT_REGION=us-west-2

# send files
aws s3 sync ${OUTPUT_DIR} s3://docs.getchip.com/ --delete --exclude ".git/*" --exclude "*.sh" --exclude "CNAME" --exclude "README.md" --exclude "gulpfile.js" --exclude "package.json" --exclude "src/*"

# let things settle...
echo "Sleeping for 30 seconds"
sleep 30

# invalidate cloudfront cache
aws configure set preview.cloudfront true
aws cloudfront create-invalidation --distribution-id E3BUJIDTZ80HE3 --paths '/*'
aws cloudfront create-invalidation --distribution-id E28FEOY1JNHBO4 --paths '/*'
