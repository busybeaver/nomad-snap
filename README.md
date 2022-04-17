# HomeLab: Packages, Services, and Applications

Building, packaging, and publishing services and applications for the personal HomeLab.

**Note:** The original licenses of all services/packages below stay untouched/intact. Please refer to the websites/repositories of each service to get more information about the respective licenses.

## Target Systems/Environments

- [Ubuntu Core](https://ubuntu.com/core) ([Snap Packages](https://snapcraft.io/))
- [Synology DSM](https://www.synology.com/en-global/dsm) ([SPK Packages](https://kb.synology.com/en-us/DSM/tutorial/How_to_install_applications_with_Package_Center))
- [Docker](https://www.docker.com/) ([Images](https://hub.docker.com/))

## Snap Packages

Published to the [Snapcraft store](https://snapcraft.io/) (right now privately/unlisted).

- HashiCorp [Nomad](https://www.nomadproject.io/)
- HashiCorp [Consul](https://www.consul.io/)

_Note:_ Canonical provides a HashiCorp [Vault snap package](https://snapcraft.io/vault), so no need to build/create it.

## SPK Packages

- todo

## Docker Images

Docker images are pushed/published to GitHub packages (the ghcr.io registry) within this repository.

- A modified [HomeAssistant](https://www.home-assistant.io/) version that can be run as non-root user
- A minimal act runner environment with Python 3 installed

## Setup

On macOS run the following command to install lefthook:

```shell
brew install lefthook dprint
```

For other operating systems, have a look at the installation section in the [lefthook install documentation](https://github.com/evilmartians/lefthook/blob/4d074e16260327fa22d05cc01c959825e8abc80a/docs/other.md) and the [dprint docs](https://dprint.dev/install/).

Subsequently, setup lefthook by running:

```shell
lefthook install && dprint config init
```

## Development

Use [act](https://github.com/nektos/act) to run the GitHub Actions CI flow locally.
