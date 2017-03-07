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
  

## Edit and Review Flow

How to push and switch from unstable to testing to stable branches. 

### Unstable

To start working with the docs for the first time, clone the upstream branches:

`git clone <upstream url>`

Make sure you are on the unstable branch:

`git branch`
`git checkout unstable`

Edit and add any files you need. When you are ready to review check out the branch status to see if there are any unchecked files:

`git status`

Add any unchecked files to git:

`add <file path>`  You can add whole directory to make it quicker.

Commit changes:

`git commit -m "commit message"`

Push changes to sync upstream with your local computer:

`git push`

Review your changes at http://ntc-docs-unstable.surge.sh/

### Testing

How to move from unstable to testing branch.

Commit all changes to unstable and switch to testing branch:

`git checkout testing`

Merge unstable with testing (everything from unstable will merge unless you cherry-pick):

`git merge unstable`

To choose a commit to merge, look at all the commits and grab commit-hash:

`git log`

Choose the commit to merge:

`git cherry-pick <commit-hash>`

Push and sync changes:

`git push`

Get peers to review your changes at http://ntc-docs-testing.surge.sh/

## History

In the past, the documetation is spread over 6 different repositories on github.com:

  - The CHIP documentation: https://github.com/getchip/CHIP-docs
  - The DIP documentation: https://github.com/getchip/DIP-docs
  - The PocketCHIP documentation: https://github.com/getchip/PocketCHIP-docs
  - The CHIP PRO documentation: https://github.com/getchipHIP_Pro-Docs
  - The CHIP PRO Devkit documentation: https://github.com/getchip/CHIP_Pro-_DKit-Docs
  - The landing page: https://github.com/getchip/landingpage

They should soon be deleted.
