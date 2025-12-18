#!/bin/bash

# Only run once per container
if [ -z "${GAPROOT_SYMLINKED:-}" ]; then
  export GAPROOT_SYMLINKED=1
  BLAH="$PWD"
  echo $BLAH > /test.txt
  ln -sf "$PWD" /tmp/gaproot/pkg/
fi
