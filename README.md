# gda-image: GAP Docker images for GitHub Actions

This repository contains (unofficial!) Docker images with GAP and its packages pre-installed inside a (slim) Ubuntu environment. They are not meant to be ran interactively - it is recommended to use the official GAP Docker images for that purpose: [master](https://github.com/gap-system/gap-docker-master), [4.11](https://github.com/gap-system/gap-docker-stable-4.11), [4.10](https://github.com/gap-system/gap-docker-stable-4.10) and [4.9](https://github.com/gap-system/gap-docker-stable-4.9).

## Available images

The following images are available:

- `master`, `master-slim`: for testing on the `master` branch, built on Ubuntu 22.04 LTS (Jammy Jellyfish);
- `4.11`, `4.11-slim`: for testing on the `stable-4.11` branch, built on Ubuntu 20.04 LTS (Focal Fossa);
- `4.10`, `4.10-slim`: for testing on the `stable-4.10` branch, built on Ubuntu 18.04.6 LTS (Bionic Beaver);
- `4.9`, `4.9-slim`: for testing on the `stable-4.9` branch, built on Ubuntu 18.04.6 LTS (Bionic Beaver);
- `tex`, `tex-slim`: for building manuals, built on Ubuntu 22.04 LTS (Jammy Jellyfish).

## Available packages

### Full images

The full images contain the following:
  * tools to install and build additional packages:
    * build-essential
    * git
    * ...
  * almost all GAP packages that come with GAP by default, except:
    * linboxing
    * itc
    * PolymakeInterface
    * xgap
  * some of the external dependencies used by GAP packages:
    * 4ti2
    * cdd
    * curl
    * fplll
    * mpc
    * mpfi
    * mpfr
    * ncurses
    * pari-gp
    * polymake
    * singular
    * zmq
  
### Slim images
  
The `slim` images are much smaller, and contain the following:
  * no tools to install and build additional packages;
  * more or less only those GAP packages that GAP loads by default:
    * aclib
    * alnuth
    * atlasrep
    * autodoc
    * autpgrp
    * browse
    * caratinterface (or carat)
    * crisp
    * cryst
    * crystcat
    * ctbllib
    * cvec
    * factint
    * fga
    * forms
    * gapdoc
    * genss
    * io
    * irredsol
    * laguna
    * orb
    * polenta
    * polycyclic
    * primgrp
    * profiling
    * radiroot
    * recog (and recogbase)
    * resclasses
    * smallgrp
    * sophus
    * spinsym
    * tomlib
    * transgrp
    * utils
  * some of the external dependencies used by these GAP packages:
    * ncurses
    * pari-gp

## TODO
- Set appropriate cron schedules
