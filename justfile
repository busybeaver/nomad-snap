set dotenv-load := true
set shell := ["zsh", "-uc"]

# lists all available commands
@default:
  just --list

alias init := initialize
alias fmt := format

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

# formats files according to the used standards
format:
  @just _run_shared format

# checks if the files comply to the used standards
check:
  @just _run_shared check

# runs the CI workflows locally
ci *args:
  @just _run_shared ci {{args}}

# -----------------------
# repo specific tooling:
# -----------------------

alias snap := snap_build
alias docker := docker_build

# builds the specified snap package
snap_build package:
  @# With --debug, if snapcraft encounters an error it will automatically open a shell within snap’s virtual environment (allows to explore the build issue directly)
  cd {{justfile_directory()}}/snaps/{{package}}/ && snapcraft --debug

# builds the specified docker image
docker_build package:
  cd {{justfile_directory()}}/docker/{{package}}/ && docker build -t local-build_{{package}} .
