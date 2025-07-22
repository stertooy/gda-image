
ARG BASE_IMAGE=ubuntu:latest

FROM ${BASE_IMAGE} AS build

ENV DEBIAN_FRONTEND=noninteractive

ENV GAPROOT="/opt/gap"
ARG GAPDEPS
ARG VERSION="master"
ARG PACKAGES

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN <<EOF
    apt-get update
    apt-get upgrade --yes
    apt-get install --yes --no-install-recommends ${GAPDEPS}
EOF

# Download GAP
RUN <<EOF
    if [ "${VERSION}" = "master" ]; then
        GAP_URL="https://github.com/gap-system/gap/archive/master.tar.gz"
    else
        GAP_URL="https://github.com/gap-system/gap/releases/download/v${VERSION}/gap-${VERSION}.tar.gz"
    fi
    echo $GAP_URL
    wget -O - $GAP_URL | tar -xzf - --one-top-level=${GAPROOT} --strip-components=1
    cd ${GAPROOT}
    echo ls -a
    rm -rf extern .github
EOF

# Build GAP
RUN <<EOF
    cd ${GAPROOT}
    ./autogen.sh
    ./configure
    make -j3
EOF

# Download packages if necessary, remove unwanted ones
RUN <<EOF
    if [ "${VERSION}" = "master" ]; then
        wget -O - https://github.com/gap-system/PackageDistro/releases/download/latest/packages.tar.gz | tar -xzf - --one-top-level=${GAPROOT}/pkg
    fi
    cd ${GAPROOT}/pkg
    echo "List of packages: ${PACKAGES}"
    for pkg in */; do
        pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
        echo "Now checking package $pkgBase"
        if [[ -n "${PACKAGES}" ]]; then
            if ! grep -Fwq "$pkgBase" <<< "${PACKAGES}"; then
              echo "Removing package $pkgBase"
              rm -rf $pkg
            else
              echo "Keeping package $pkgBase"
            fi
        fi
    done
EOF

# Build GAP docs
RUN <<EOF
    if [ "${VERSION}" == "master" ]; then
        cd ${GAPROOT}
        make html || :
    fi
EOF

# Build packages
#RUN <<EOF
#    cd ${GAPROOT}/pkg
#    ../bin/BuildPackages.sh
#EOF

# Add GAP to PATH
RUN <<EOF
    printf '#!/bin/bash\n%s/gap "$@"\n' ${GAPROOT} > /usr/local/bin/gap
    chmod +x /usr/local/bin/gap
EOF

# Squash
FROM scratch
COPY --from=build / /

RUN <<EOF
    echo $GAPROOT
    echo $DEBIAN_FRONTEND
EOF

CMD ["bash"]
