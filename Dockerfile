# syntax=docker/dockerfile:1.3-labs

ARG GAP_HOME={{GAP_HOME}}
ARG GAP_ROOT={{GAP_ROOT}}

FROM {{BASE_IMAGE}} as build

ARG GAP_HOME
ARG GAP_ROOT
ENV VERSION="{{VERSION}}"
ENV PACKAGE_LIST="{{PACKAGE_LIST}}"
ENV PACKAGE_MODE="{{PACKAGE_MODE}}"
ENV TEMP_DEPS="{{TEMP_DEPS}}"
ENV PERM_DEPS="{{PERM_DEPS}}"

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN <<EOF
    apt-get update
    apt-get upgrade --yes
    apt-get install --yes --no-install-recommends ${TEMP_DEPS} ${PERM_DEPS}
EOF

# Download GAP
RUN <<EOF
    cd /tmp
    if [ "${VERSION}" = "master" ] || [ "${VERSION}" = "tex" ]; then
        wget -q https://github.com/gap-system/gap/archive/master.tar.gz -O gap.tar.gz
    else
        wget -q https://github.com/gap-system/gap/releases/download/v${VERSION}/gap-${VERSION}.tar.gz -O gap.tar.gz
    fi
    tar -xzf gap.tar.gz
    rm -rf gap.tar.gz
    mv gap* ${GAP_HOME}
    cd ${GAP_HOME}
    rm -rf extern .github
EOF

# Build GAP
RUN <<EOF
    cd ${GAP_HOME}
    ./autogen.sh
    ./configure
    make -j3
    if [ "${VERSION}" != "tex" ]; then
        make clean-doc
    fi
EOF

# Download packages if necessary, remove unwanted ones
RUN <<EOF
    if [ "${VERSION}" = "master" ] || [ "${VERSION}" = "tex" ]; then
        mkdir ${GAP_HOME}/pkg
        cd ${GAP_HOME}/pkg
        wget -q https://github.com/gap-system/PackageDistro/releases/download/latest/packages.tar.gz
        tar -xzf packages.tar.gz
        rm packages.tar.gz
    else
        cd ${GAP_HOME}/pkg
    fi
    for pkg in */; do
        pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
        if [ "${PACKAGE_MODE}" = "delete" ]; then
            if grep -Fwq "$pkgBase" <<< "${PACKAGE_LIST}"; then
                rm -rf $pkg
            fi
        else
            if ! grep -Fwq "$pkgBase" <<< "${PACKAGE_LIST}"; then
              rm -rf $pkg
            fi
        fi
    done
EOF

# Build packages
RUN <<EOF
    cd opt/gap/pkg
    ../bin/BuildPackages.sh
EOF

# Delete temporary dependencies
RUN <<EOF
    apt-get autoremove --purge --yes ${TEMP_DEPS}
    rm -rf /var/lib/apt/lists/*
EOF

# Prepare for Github Actions use
RUN <<EOF
    mkdir -p /tmp/gaproot/pkg
    printf '#!/bin/bash\nLC_CTYPE=C.UTF-8 TERM="xterm" %s/gap -l "%s;" --quitonbreak "$@"\n' ${GAP_HOME} ${GAP_ROOT} > /usr/local/bin/gap
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
ENV GAPROOT ${GAP_HOME}

CMD ["bash"]
