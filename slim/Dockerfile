# syntax=docker/dockerfile:1.3-labs

ARG GAP_BRANCH={{GAP_BRANCH}}
ARG GAP_HOME=/opt/gap
ARG GAP_ROOT=/tmp/gaproot
ARG GAP_PACKAGES={{GAP_PACKAGES}}
ARG GAP_PKGS_URL={{GAP_PKGS_URL}}
ARG BASE_IMAGE={{BASE_IMAGE}}
ARG TEMP_DEPENDENCIES={{TEMP_DEPENDENCIES}}
ARG PERM_DEPENDENCIES={{PERM_DEPENDENCIES}}

FROM ${BASE_IMAGE} as build

ARG GAP_BRANCH
ARG GAP_HOME
ARG GAP_ROOT
ARG GAP_PACKAGES
ARG TEMP_DEPENDENCIES
ARG PERM_DEPENDENCIES

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN <<EOF
    apt-get update
    apt-get upgrade --yes
    apt-get install --yes --no-install-recommends ${TEMP_DEPENDENCIES} ${PERM_DEPENDENCIES}
EOF

# Download GAP
RUN <<EOF
    cd /tmp
    wget -q https://github.com/gap-system/gap/archive/${GAP_BRANCH}.tar.gz -O gap.tar.gz
    tar -xzf gap.tar.gz
    rm -rf gap.tar.gz
    mv gap* ${GAP_HOME}
    cd ${GAP_HOME}
    rm -rf dev extern hpcgap
EOF

# Build GAP
RUN <<EOF
    cd ${GAP_HOME}
    ./autogen.sh
    ./configure
    make
    rm -rf obj cnf
EOF

# Download packages
RUN <<EOF
    mkdir ${GAP_HOME}/pkg
    cd ${GAP_HOME}/pkg
    wget -q ${GAP_PKGS_URL} -O packages.tar.gz
    tar -xzf packages.tar.gz
    rm packages.tar.gz
    for pkg in */; do
        pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
        if ! grep -Fwq "$pkgBase" <<< "${GAP_PACKAGES}"; then
            rm -rf $pkg
        fi
    done
EOF

# Build packages
RUN cd opt/gap/pkg && \
    ../bin/BuildPackages.sh

# Delete temporary dependencies
RUN <<EOF
    apt-get autoremove --purge --yes ${TEMP_DEPENDENCIES}
    rm -rf /var/lib/apt/lists/*
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

# Make GAP_HOME and GAP_ROOT available in container
ARG GAP_HOME
ENV GAP_HOME ${GAP_HOME}
ARG GAP_ROOT
ENV GAP_ROOT ${GAP_ROOT}

CMD ["bash"]
