
ARG BASE_IMAGE=ubuntu:latest
ARG GAPROOT="/opt/gap"

FROM $BASE_IMAGE AS build

ARG GAPROOT
ARG GAPDEPS
ARG VERSION="master"
ARG PACKAGES

ENV DEBIAN_FRONTEND=noninteractive
ENV GAPROOT=$GAPROOT

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN <<EOF
    apt-get update
    apt-get upgrade --yes
    apt-get install --yes --no-install-recommends ${GAPDEPS}
EOF

# Download GAP
RUN <<EOF
    if [ "$VERSION" = "master" ]; then
        GAP_URL="https://github.com/gap-system/gap/archive/master.tar.gz"
    else
        GAP_URL="https://github.com/gap-system/gap/releases/download/v$VERSION/gap-$VERSION.tar.gz"
    fi
    wget -O - $GAP_URL | tar -xzf - --one-top-level=$GAPROOT --strip-components=1
    cd $GAPROOT
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
    if [ "$VERSION" = "master" ]; then
        wget -O - https://github.com/gap-system/PackageDistro/releases/download/latest/packages.tar.gz | tar -xzf - --one-top-level=$GAPROOT/pkg
    fi
    cd $GAPROOT/pkg
    if [[ -n "$PACKAGES" ]]; then
        for pkg in */; do
            pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
                if ! grep -Fwq "$pkgBase" <<< "$PACKAGES"; then
                  echo "Removing package $pkgBase"
                  rm -rf $pkg
                else
                  echo "Keeping package $pkgBase"
                fi
        done
    fi
EOF

# Build GAP docs
RUN <<EOF
    if [ "$VERSION" == "master" ]; then
        cd $GAPROOT
        make html || :
    fi
EOF

# Build packages
RUN <<EOF
    cd ${GAPROOT}/pkg
    ../bin/BuildPackages.sh
    echo "Showing output log of BuildPackages.sh"
    cat log/fail.log
EOF

# Add GAP to PATH
RUN <<EOF
    mkdir -p /tmp/gaproot/pkg/
    echo -e '#!/bin/bash\n'"$EXEC"' -l "/tmp/gaproot;" "$@"\n' > /usr/local/bin/gap
    chmod +x /usr/local/bin/gap
EOF

# Make folder
RUN <<EOF
    mkdir -p /tmp/gaproot/pkg
    
EOF

# Squash
FROM scratch
COPY --from=build / /

ARG GAPROOT

ENV DEBIAN_FRONTEND=noninteractive
ENV GAPROOT=$GAPROOT
ENV GAP="gap --quitonbreak"

RUN <<EOF
    echo $GAPROOT
    echo $DEBIAN_FRONTEND
    echo $GAP
EOF

CMD ["bash"]
