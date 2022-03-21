# nomad-homelab

[HashiCorp Nomad](https://www.nomadproject.io/) packaged/bundled as a [Snap package](https://snapcraft.io/) to be used e.g. on [Ubuntu Core](https://ubuntu.com/core) systems.

## Installation

The snap package can be installed by running:

```shell
sudo snap install nomad-homelab
```

_Note:_ The package is currently published privately, so only selected Ubuntu One accounts can download/install it from the Snapcraft store.

## Post-installation Steps

After the installation, the necessary non-autoconnecting interfaces need to be (manually) connected:

```shell
sudo snap connect nomad-homelab:mount-observe :mount-observe
sudo snap connect nomad-homelab:network-observe :network-observe
# TODO: add docker plug/connection
```

More information can be found in the [interface management documentation](https://snapcraft.io/docs/interface-management)

## Usage

The available CLI commands are documented in the official [Nomad documentation](https://www.nomadproject.io/docs/commands). However, instead of using `nomad`, the `nomad-homelab` command needs to be used.

```shell
nomad-homelab --help
```

### Running as Service/Daemon

Nomad can be run as a service/daemon, so it gets automatically (re)started on system restarts, updates, etc.

To do so, first one or more [configuration files](https://www.nomadproject.io/docs/configuration) need to be provided so Nomad runs with the expected parameters.
The files need to stored into the `$SNAP_DATA/config/` folder (usually `/var/snap/nomad-homelab/current/config/`).

```shell
# start the service
sudo snap start nomad-homelab.daemon
# start the service and ensure it gets restarted on e.g. restarts
sudo snap start --enable nomad-homelab.daemon
# view logs
sudo snap logs nomad-homelab
# stop the service
sudo snap stop nomad-homelab.daemon
# stop the service and ensure it doesn't get restarted (again) on e.g. restarts
sudo snap stop --disable nomad-homelab.daemon
```

## Uninstall

Analogously, the snap package can be uninstalled by running:

```shell
sudo snap remove nomad-homelab
```

## Nomad Documentation

For more information, tutorials, and documentation about Nomad, please refer to the official [Nomad homepage](https://www.nomadproject.io/).
