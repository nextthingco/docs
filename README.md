# NTC docs builder

This repository contains scripts to regenerate the documentation webpages for CHIP,
PocketCHIP, DIPs, CHIP PRO and the CHIP PRO Devkit.

The documentations are hosted in separate respositories on [github](http://github.com/getchip):
  - The CHIP documentation: https://github.com/getchip/CHIP-docs
  - The DIP documentation: https://github.com/getchip/DIP-docs
  - The PocketCHIP documentation: https://github.com/getchip/PocketCHIP-docs
  - The CHIP PRO documentation: https://github.com/getchipHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://github.com/getchip/CHIP_Pro-_DKit-Docs
  - The landing page: https://github.com/getchip/landingpage

## History

The documentation previously has been build on our Bamboo instance.
As Atlassian cancelled it's hosted Bamboo service end of January 2017,
the generation of the documentation has been moved to our hosted gitlab instance https://ntc.githost.io.

## Gitlab / ntc.githost.io
This repostiory contains a `.gitlab-ci.yml` file and new builds of the documentation
can be triggered via webhooks.

The actual documentation is currently hosted on github.com.
