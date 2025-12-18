#!/bin/bash
ln -f -s "$PWD" /tmp/gaproot/pkg/
exec "$@"
