# syntax=docker/dockerfile:1.3-labs
FROM debian:stretch-slim as build

ENV GAP_BRANCH=stable-4.9
ENV GAP_HOME=/opt/gap
ENV GAP_ROOT=/tmp/gaproot

# Prerequisites
RUN <<EOF
    apt update
    apt upgrade
    apt install --yes --no-install-recommends   \
        autoconf                                    \
        build-essential                             \
        ca-certificates                             \
        git                                         \
        libgmp-dev                                  \
        libncurses-dev        `# Browse`            \
        libtool                                     \
        pari-gp               `# Alnuth`            \
        netbase               `# IO`                \
        wget                                        \
        zlib1g-dev
    rm -rf /var/lib/apt/lists/*
EOF

# Download and build GAP
RUN <<EOF
    git clone --depth 1 --branch ${GAP_BRANCH} https://github.com/gap-system/gap ${GAP_HOME}
    cd ${GAP_HOME}
    rm -rf       \
        dev      \
        extern   \
        hpcgap
EOF

# Build GAP
RUN <<EOF
    cd ${GAP_HOME}
    ./autogen.sh
    ./configure
    make
EOF

# Download GAP packages
RUN <<EOF
    cd ${GAP_HOME}
    make bootstrap-pkg-full
    rm packages*.tar.gz
    cd ${GAP_HOME}/pkg
    for pkg in */
    do
        pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
        if ! cat << '        PKGS' | grep -Fwq "$pkgBase"
            aclib
            alnuth
            atlasrep
            autodoc
            autpgrp
            browse
            carat
            caratinterface
            crisp
            cryst
            crystcat
            ctbllib
            factint
            fga
            forms
            gapdoc
            genss
            io
            irredsol
            laguna
            orb
            polenta
            polycyclic
            primgrp
            profiling
            radiroot
            recog
            recogbase
            resclasses
            smallgrp
            sophus
            spinsym
            tomlib
            transgrp
            utils
        PKGS
        then 
            rm -rf $pkg
        fi
    done
EOF

# Build GAP packages
RUN <<EOF
    cd ${GAP_HOME}/pkg
    ../bin/BuildPackages.sh
EOF

# Prepare for Github Actions use
RUN <<EOF
    mkdir -p /tmp/gaproot/pkg
    printf '#!/bin/sh\nLC_CTYPE=C.UTF-8 TERM="xterm" %s/bin/gap.sh -l "%s;" --quitonbreak "$@"\n' ${GAP_HOME} ${GAP_ROOT} > /usr/local/bin/gap
    chmod +x /usr/local/bin/gap
EOF

# Squash
FROM scratch
COPY --from=build / /

CMD ["bash"]
