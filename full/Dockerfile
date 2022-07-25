# syntax=docker/dockerfile:1.3-labs
FROM {{IMAGE}} as build

ENV GAP_HOME=/opt/gap

SHELL ["/bin/bash", "-c"]

# Prerequisites
RUN <<EOF
    apt-get update
    apt-get install --yes --no-install-recommends {{DEPENDENCIES}}
    rm -rf /var/lib/apt/lists/*
EOF

# Download GAP packages
RUN <<EOF
    cd ${GAP_HOME}
    rm -rf pkg
    make bootstrap-pkg-full
    rm packages*.tar.gz
    cd ${GAP_HOME}/pkg
    for pkg in */; do
        pkgBase=$(echo $pkg | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]*$//g')
        if grep -Fwq "$pkgBase" <<< "{{PACKAGES}}"; then
            rm -rf $pkg
        fi
    done
EOF

# Build GAP packages
RUN <<EOF
    cd ${GAP_HOME}/pkg
    ../bin/BuildPackages.sh
EOF

# Squash
FROM scratch
COPY --from=build / /

CMD ["bash"]
