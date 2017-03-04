# Docs 

This repository contains the sources of the documentation for CHIP, the DIPS, PocketCHIP, CHIP PRO, and the CHIP PRO DevKit.

## Organisation

In order to simplify things, all of the documention has been moved into subdirectories of this repository:

  - The CHIP documentation: https://ntc.githost.io/nextthingco/docs/CHIP-docs
  - The DIP documentation: https://ntc.githost.io/nextthingco/docs/DIP-docs
  - The PocketCHIP documentation: https://ntc.githost.io/nextthingco/docs/PocketCHIP-docs
  - The CHIP PRO documentation: https://ntc.githost.io/nextthingco/docs/CHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://ntc.githost.io/nextthingco/docs/CHIP_Pro-_DKit-Docs
  - The landing page: https://ntc.githost.io/nextthingco/docs/landingpage

## Branches

There are four branches:

  - `docker`: Contains everything to build the docker container which then builds the docs. Don't touch unless you know what you're doing.
  - `unstable`: Do your experiments in here. Breaking the build is explicitly allowed (as long as you fix it afterwards). Results will be published at http://ntc-docs-unstable.surge.sh.
  - `testing`: Prepare the next release in here.  Proof-reading should be done at http://ntc-docs-testing.surge.sh.
  - `stable`: Everything in here will be published to https://docs.getchip.com and https://docs.nextthing.co. Be careful what you do in here.

## History

In the past, the documetation is spread over 6 different repositories on github.com:

  - The CHIP documentation: https://github.com/getchip/CHIP-docs
  - The DIP documentation: https://github.com/getchip/DIP-docs
  - The PocketCHIP documentation: https://github.com/getchip/PocketCHIP-docs
  - The CHIP PRO documentation: https://github.com/getchipHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://github.com/getchip/CHIP_Pro-_DKit-Docs
  - The landing page: https://github.com/getchip/landingpage

They should soon be deleted.
