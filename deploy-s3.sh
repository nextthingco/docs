#!/bin/bash

set -e
set -x

#NOTE: no pushd here!

export GIT_DEPLOY_DIR="${bamboo.build.working.directory}/output"

# login aws cli
export AWS_ACCESS_KEY_ID=${bamboo.AwsAccessKeyId}
export AWS_SECRET_ACCESS_KEY=${bamboo.AwsSecretAccessKeyPassword}
export AWS_DEFAULT_REGION=us-west-2

# send files
aws s3 sync ${GIT_DEPLOY_DIR} s3://docs.getchip.com/ --delete --exclude ".git/*" --exclude "*.sh" --exclude "CNAME" --exclude "README.md" --exclude "gulpfile.js" --exclude "package.json" --exclude "src/*"
# invalidate cloudfront cache
aws configure set preview.cloudfront true
aws cloudfront create-invalidation --distribution-id E3BUJIDTZ80HE3 --paths '/*'
aws cloudfront create-invalidation --distribution-id E28FEOY1JNHBO4 --paths '/*'