#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

set -x

cd "${CHECKOUT_DIRECTORY:-.}"
rm -rf .[!.]* scripts

git clone --depth 1 --filter=blob:limit=1m "${GIT_REPOSITORY:-https://github.com/busybeaver/homelab-packages.git}" .
shopt -s extglob
# ".[!.]*" matches all dot files except "." and files whose name begins with ".." // https://unix.stackexchange.com/a/77313
# "!(scripts)" matches all non dot files except the scripts folder (requires "extglob")
rm -rf .[!.]* !(scripts)
