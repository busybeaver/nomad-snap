#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "${DEBUG_SCRIPT:-}" == "TRUE" ]; then
  set -x
fi

shopt -s extglob

cd "${CHECKOUT_DIRECTORY:-.}" || exit -1
rm -rf .[!.]* scripts

git clone --branch main --single-branch --depth 1 --filter=blob:limit=1m "https://github.com/busybeaver/${GIT_REPOSITORY:-homelab-packages}.git" .
# ".[!.]*" matches all dot files except "." and files whose name begins with ".." // https://unix.stackexchange.com/a/77313
# "!(scripts)" matches all non dot files except the scripts folder (requires "extglob")
rm -rf .[!.]* !(scripts)
