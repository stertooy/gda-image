# gda-image: GAP Docker images for GitHub Actions

This repository contains (unofficial!) Docker images with GAP and its packages pre-installed inside a (minimal) Ubuntu environment. They are not meant to be ran interactively - it is recommended to use the official GAP Docker images for that purpose: [master](https://github.com/gap-system/gap-docker-master), [4.11](https://github.com/gap-system/gap-docker-stable-4.11), [4.10](https://github.com/gap-system/gap-docker-stable-4.10) and [4.9](https://github.com/gap-system/gap-docker-stable-4.9).

## Available images

The following images are available:

- `master`, `master-slim`, `master-min`;
- `4.12`, `4.12-slim`, `4.12-min`;
- `4.11`, `4.11-slim`, `4.11-min`;
- `4.10`, `4.10-slim`, `4.10-min`;
- `4.9`, `4.9-slim`, `4.9-min`;
- `tex`, `tex-slim`, `tex-min`.

Each image is built on an LTS version of Ubuntu that was released around the same time as that particular version of GAP, i.e. 18.04 for `4.9` and `4.10`, 20.04 for `4.11` and 22.04 for `4.12`, `master` and `tex`.

## Available packages

### Full images

The full images are rather large (650 MB - 1.1 GB when compressed). They contain the following:
  * tools to install and build additional packages:
    * autoconf
    * build-essential
    * git
    * libtool
  * all GAP packages that GAP is distributed with, except:
    * linboxing
    * itc
    * polymakeinterface
    * qaos
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
    * netbase
    * pari-gp
    * polymake
    * singular
    * wget
    * zmq
  
### Slim images
  
The `slim` images are much smaller (250 MB - 450 MB when compressed). They contain the following:
  * tools to install (but not build) additional packages:
    * git
  * more or less only those GAP packages that GAP loads by default, as well as those needed to build manuals and to make coverage reports:
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
    * netbase
    * pari-gp
    * wget

### Minimal images
  
The `min` images are even smaller (120 MB - 175 MB when compressed). They contain the following:
  * tools to install (but not build) additional packages:
    * git
  * only those GAP packages needed to run GAP, to build manuals and to make coverage reports:
    * autodoc
    * gapdoc
    * io
    * primgrp
    * profiling
    * smallgrp
    * transgrp
  * some of the external dependencies used by these GAP packages:
    * netbase
