# gda-image: GAP Docker images for GitHub Actions

This repository contains (unofficial!) Docker images with GAP and its packages pre-installed inside a (minimal) Ubuntu environment. They are not meant to be ran interactively - it is recommended to use the official GAP Docker images for that purpose: [master](https://github.com/gap-system/gap-docker-master), [4.11](https://github.com/gap-system/gap-docker-stable-4.11), [4.10](https://github.com/gap-system/gap-docker-stable-4.10) and [4.9](https://github.com/gap-system/gap-docker-stable-4.9).

The images follow a naming schema of VERSION-TYPE.

## Available versions

The following versions of GAP are available:
  - `4.12.0`
  - `4.12.1`
  - `4.12.2`
  - `4.13.0`
  - `4.13.1`
  - `4.13.2`
  - `4.14.0`
  - `4.15.0-beta3`
  - `master` (the current `master` branch of the GAP source code repository)

Each image is built on an LTS version of Ubuntu that was released around the same time as that particular version of GAP (or a newer LTS release if necessary):
  - 22.04 for `4.12.0` - `4.12.2`
  - 24.04 for `4.13.0` and later (including `master`)


## Available types

The following types of images are available:
  - `full`
  - `slim`

### Full images

The `full` images are rather large (3GB - 5GB when compressed). They contain the following:
  * tools to install additional packages
  * tools to run GitHub actions
  * a basic texlive installation to create package documentation
  * all GAP packages that GAP is distributed with
  * most of the external dependencies used by these GAP packages
  
### Slim images
  
The `slim` images are smaller (1GB - 1.5GB when compressed). They contain the following:
  * tools to install additional packages
  * tools to run GitHub actions
  * the GAP packages that GAP loads by default, as well as those needed for GAP's GitHub actions
  * most of the external dependencies used by these GAP packages
