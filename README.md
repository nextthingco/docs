# docker branch

Contains everything to build the docker container which then builds the docs.
Don't touch unless you know what you're doing.

## Continous Integration

The `.gitlab-ci.yml` contains three build stages. Any change pushed to the `docker` branch will:
  * build: builds a new Docker image
  * test:
      * using the new image, try to build & publish the `stable` branch to https://ntc-docs-docker.surge.sh (`test.sh`)
      * an automated test (`test2.sh`will run to verify if each of the sub-pages on the front page are accessible. Feel free to add deeper testing if necessary.
  * release: if the test stage succeeds, tag the newly build image and push to the docker registry.

_NOTE_: releasing a new docker image will *not* publish the `stable` branch to
https://docs.nextthing.co or https://docs.getchip.com. However, you can verify
the what would be published on the next build of the `stable` branch at
https://ntc-docs-docker.surge.sh.
