#!/bin/bash

set -ex

apt-get install wget

[ -x "$(which wget)" ] || exit 1

TMPDIR=$(mktemp -d)
URL=http://ntc-docs-${CI_BUILD_REF_NAME}.surge.sh
PAGES=$(wget -q -O - $URL |grep _blank |sed -e 's/.*href=\"\([^"]*\)\".*/\1/g')

for P in $PAGES; do
    wget -q -O $TMPDIR/$P $URL/$P || exit $?
done || exit $?

rm -rf $TMPDIR
