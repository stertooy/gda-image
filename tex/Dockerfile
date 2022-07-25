# syntax=docker/dockerfile:1.3-labs
FROM {{IMAGE}} as build

SHELL ["/bin/bash", "-c"]

# Prerequisites
RUN <<EOF
    apt-get update
    apt-get install --yes --no-install-recommends {{DEPENDENCIES}}
    rm -rf /var/lib/apt/lists/*
EOF

# Squash
FROM scratch
COPY --from=build / /

CMD ["bash"]
