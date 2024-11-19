# gda-image: GAP Docker images for GitHub Actions

This repository contains (unofficial!) Docker images with GAP and its packages pre-installed inside a (minimal) Ubuntu environment. They are not meant to be ran interactively - it is recommended to use the official GAP Docker images for that purpose: [master](https://github.com/gap-system/gap-docker-master), [4.11](https://github.com/gap-system/gap-docker-stable-4.11), [4.10](https://github.com/gap-system/gap-docker-stable-4.10) and [4.9](https://github.com/gap-system/gap-docker-stable-4.9).

The images follow a naming schema of VERSION-TYPE.

## Available versions

The following versions of GAP are available:
  - `4.10.0`
  - `4.10.1`
  - `4.10.2`
  - `4.11.0`
  - `4.11.1`
  - `4.12.0`
  - `4.12.1`
  - `4.12.2`
  - `4.13.0`
  - `4.13.1`
  - `4.13.2`
  - `4.14.0-beta-1`
  - `master` (the current `master` branch of the GAP source code repository)
  - `tex` (the current `master` branch of the GAP source code repository, plus a minimal tex installation) 

Each image is built on an LTS version of Ubuntu that was released around the same time as that particular version of GAP (or a newer LTS release if necessary):
  - 20.04 for `4.19.0` -  `4.11.1`
  - 22.04 for `4.12.0` - `4.12.2`
  - 24.04 for `4.13.0` and later (including `master` and `tex`)


## Available types

The following types of images are available:
  - `full`
  - `slim`
  - `min`

### Full images

The `full` images are rather large (600 MB - 1.2GB when compressed). They contain the following:
  * basic tools to install and build additional packages
  * all GAP packages that GAP is distributed with, except for packages that are defunct, withdrawn, or do not work in a standard GAP session
  * most of the external dependencies used by these GAP packages
  
### Slim images
  
The `slim` images are much smaller (250 MB - 350 MB when compressed). They contain the following:
  * minimal tools to install (but not build) additional packages
  * the GAP packages that GAP loads by default, as well as those needed to build manuals and to make coverage reports
  * most of the external dependencies used by these GAP packages

### Minimal images
  
The `min` images are even smaller (130 MB - 200 MB when compressed). They contain the following:
  * minimal tools to install (but not build) additional packages
  * only those GAP packages needed to run GAP, to build manuals and to make coverage reports
  * most of the external dependencies used by these GAP packages
