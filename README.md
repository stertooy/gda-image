# gda-image: GAP Docker images for GitHub Actions

This repository contains docker images with GAP and (as many as possible of) its packages pre-installed inside a (slim) Debian environment.

## Available images

The following images are available:

- `master`: contains the GAP `master` branch, built upon Debian's `bookworm-slim` image;
- `4.11`: contains the GAP `stable-4.11` branch, built upon Debian's `bullseye-slim` image;
- `4.10`: contains the GAP `stable-4.10` branch, built upon Debian's `buster-slim` image;
- `4.9`: contains the GAP `stable-4.9` branch, built upon Debian's `stretch-slim` image;
- `tex`: contains the GAP `master` branch, as well as texlive-packages required to build manuals, built upon Debian's `bookworm-slim` image.

## TODO

- Make `-slim'-builds of each image, containing only packages that do not rely on external software (or packages relying on those packages, etc)
- Let non-slim images build upon slim ones.
- Set appropriate cron schedules
