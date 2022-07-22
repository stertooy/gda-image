# gda-image: Docker containers GAP Docker Actions

This repository contains docker images with GAP and (as many as possible of) its packages pre-installed. It is a fork of [Docker](https://www.docker.com/)

## Available images

The following images are available:

- `master`: contains the GAP `master` branch, built upon Debian's `bookworm-slim` image;
- `4.11`: contains the GAP `stable-4.11` branch, built upon Debian's `bullseye-slim` image;
- `4.10`: contains the GAP `stable-4.10` branch, built upon Debian's `buster-slim` image;
- `4.9`: contains the GAP `stable-4.9` branch, built upon Debian's `stretch-slim` image;
- `tex`: contains the GAP `master` branch, as well as texlive-packages required to build manuals, built upon Debian's `bookworm-slim` image.
