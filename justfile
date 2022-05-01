set shell := ["bash", "-uc"]

# lists all available commands
@default:
  just --list

alias init := initialize
alias fmt := format
alias cm := commit

# internal helper command to easier run commands from the shared justfile
_run_shared cmd *args:
  @just -f {{justfile_directory()}}/.github/justfile.shared -d {{justfile_directory()}} {{cmd}} {{args}}

# install all required tooling for development (osx only)
install:
  @just _run_shared install snapcraft
  brew install --cask multipass

# initializes the tooling for working with this repository
initialize:
  @just _run_shared initialize

# formats files according to the used standards and rules; if the optional files parameter is provided, only the specified files are formatted; else all files are formatted
format *files:
  @just _run_shared format {{files}}

# checks if the files comply to the used standards and rules; if the optional files parameter is provided, only the specified files are checked; else all files are checked
check *files:
  @just _run_shared check {{files}}

# assisted conventional commits with git
commit *args:
  @just _run_shared commit {{args}}

# runs the CI workflows locally; the optional args parameter allows to add additional optional arguments
ci *args:
  @just _run_shared ci {{args}}

# -----------------------
# repo specific tooling:
# -----------------------

alias snap := snap_build
alias docker := docker_build

# builds the snap specified in the package parameter
snap_build package:
  @# With --debug, if snapcraft encounters an error it will automatically open a shell within snap’s virtual environment (allows to explore the build issue directly)
  cd {{justfile_directory()}}/snaps/{{package}}/ && snapcraft --debug

# generate a login/API token used for pushing releases to the snapcraft store
snap_create_login_token:
  #!/usr/bin/env bash
  set -euo pipefail
  IFS=$'\n\t'
  cd {{justfile_directory()}}/
  SNAPS=$(ls -m snaps | tr -d ' ')
  snapcraft export-login --snaps="$SNAPS" --acls="package_access,package_push,package_update,package_release" .login_token.txt

# builds the docker image specified in the package parameter
docker_build package *args:
  cd {{justfile_directory()}}/docker/{{package}}/ && docker build {{args}} -t local-build_{{package}} .
