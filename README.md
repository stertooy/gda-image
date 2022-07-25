# gda-image: GAP Docker images for GitHub Actions

This repository contains docker images with GAP and its packages pre-installed inside a (slim) Debian environment.

## Available images

The following images are available:

- `master`, `master-slim`: contains the GAP `master` branch, built upon Debian's `bookworm-slim` image;
- `4.11`, `4.11-slim`: contains the GAP `stable-4.11` branch, built upon Debian's `bullseye-slim` image;
- `4.10`, `4.10-slim`: contains the GAP `stable-4.10` branch, built upon Debian's `buster-slim` image;
- `4.9`, `4.9-slim`: contains the GAP `stable-4.9` branch, built upon Debian's `stretch-slim` image;

## Available packages

The standard images contain all packages that come with GAP by default, except:
  * linboxing
  * itc
  * PolymakeInterface
  * qaos
  * xgap
  
The `slim` images contain only a selection of the available packages:

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

## TODO
- Set appropriate cron schedules
