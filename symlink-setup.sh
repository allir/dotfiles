#!/usr/bin/env bash

set -euo pipefail

# This is pretty ugly, but it works on macOS without requiring coreutils for GNU readlink
# Ideally this would be:
# SCRIPT=$( readlink -f ${BASH_SOURCE[0]} )
# SCRIPTPATH=$( dirname $SCRIPT )
SCRIPT=$( cd "$(dirname ${BASH_SOURCE[0]})" &>/dev/null && pwd )/$( basename ${BASH_SOURCE[0]} )
SCRIPTPATH=$( dirname ${SCRIPT} )

for file in ${SCRIPTPATH}/.*; do
  f=$( basename $file)
  if [ ! $f = '.' ] | [ ! $f = '..' ] | [ ! $f = '.git' ]; then 
    ln -snf $file ~
  fi
done
