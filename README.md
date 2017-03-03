# Strategy for doc.getchip.com

This is a proposal to setup our servers in a way to have auto-publishing on
push after the shutdown of Bamboo-cloud-services.


## Repositories

Currently, the documetation is spread over 6 different repositories on github.com.

  - The CHIP documentation: https://github.com/getchip/CHIP-docs
  - The DIP documentation: https://github.com/getchip/DIP-docs
  - The PocketCHIP documentation: https://github.com/getchip/PocketCHIP-docs
  - The CHIP PRO documentation: https://github.com/getchipHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://github.com/getchip/CHIP_Pro-_DKit-Docs
  - The landing page: https://github.com/getchip/landingpage

In order to make things simpler, it would be of advantage to move all these
in to subdirectories of a single repository on ntc.githost.io/nextthingco/docs:

  - The CHIP documentation: https://ntc.githost.io/nextthingco/docs/CHIP-docs
  - The DIP documentation: https://ntc.githost.io/nextthingco/docs/DIP-docs
  - The PocketCHIP documentation: https://ntc.githost.io/nextthingco/docs/PocketCHIP-docs
  - The CHIP PRO documentation: https://ntc.githost.io/nextthingco/docs/CHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://ntc.githost.io/nextthingco/docs/CHIP_Pro-_DKit-Docs
  - The landing page: https://ntc.githost.io/nextthingco/docs/landingpage


## Auto-publishing / Branches

Adding a `.gitlab-ci.yml` to `ntc.githost.io/nextthingco/doc` will auto-publish
on push to the repository.

There are four branches:

  - `docker`: Contains everything to build the docker container which then builds the docs. Don't touch unless you know what you're doing.
  - `unstable`: Do your experiments in here. Breaking the build is explicitly allowed (as long as you fix it afterwards). Results will be published at http://ntc-docs-unstable.surge.sh.
  - `testing`: Prepare the next release in here.  Proof-reading should be done at http://ntc-docs-testing.surge.sh.
  - `stable`: Everything in here will be published to https://docs.getchip.com and https://docs.nextthing.co. Be careful what you do in here.
