#!/bin/bash

OUTPUT_DIR=$PWD/output
mkdir -p $OUTPUT_DIR

for what in CHIP-docs___chip PocketCHIP-docs___pocketchip DIP-docs___dip CHIP_Pro-Docs___chip_pro CHIP_Pro_DKit-Docs___chip_pro_devkit Gadget-docs___gadget; do
    a=${what%%___*} 
    b=${what##*___} 

    pushd "$a"

    if [ -d build ]; then rm -rf build; fi
    bundle install
    bundle exec middleman build --clean

    cp -rf build/* "${OUTPUT_DIR}"
    mv "${OUTPUT_DIR}/index.html" "${OUTPUT_DIR}/$b.html"
 
    popd 
done

# copy landing page
cp -rf landingpage/* "${OUTPUT_DIR}"

surge --project $PWD/output --domain ntc-docs-${CI_BUILD_REF_NAME}.surge.sh
