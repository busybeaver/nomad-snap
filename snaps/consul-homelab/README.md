# consul-homelab

[HashiCorp Consul](https://www.consul.io/) packaged/bundled as a [Snap package](https://snapcraft.io/) to be used e.g. on [Ubuntu Core](https://ubuntu.com/core) systems.

## Installation

The snap package can be installed by running:

```shell
sudo snap install consul-homelab
```

_Note:_ The package is currently published privately, so only selected Ubuntu One accounts can download/install it from the Snapcraft store.

## Usage

The available CLI commands are documented in the official [Consul documentation](https://www.consul.io/commands). However, instead of using `consul`, the `consul-homelab` command needs to be used.

```shell
consul-homelab --help
```

### Running as Service/Daemon

Consul can be run as a service/daemon, so it gets automatically (re)started on system restarts, updates, etc.

To do so, first one or more [configuration files](https://www.consul.io/docs/agent/options) need to be provided so Consul runs with the expected parameters.
The files need to stored into the `$SNAP_DATA/config/` folder (usually `/var/snap/consul-homelab/current/config/`).

```shell
# start the service
sudo snap start consul-homelab.daemon
# start the service and ensure it gets restarted on e.g. restarts
sudo snap start --enable consul-homelab.daemon
# view logs
sudo snap logs consul-homelab
# stop the service
sudo snap stop consul-homelab.daemon
# stop the service and ensure it doesn't get restarted (again) on e.g. restarts
sudo snap stop --disable consul-homelab.daemon
```

## Uninstall

Analogously, the snap package can be uninstalled by running:

```shell
sudo snap remove consul-homelab
```

## Consul Documentation

For more information, tutorials, and documentation about Consul, please refer to the official [Consul homepage](https://www.consul.io/).
