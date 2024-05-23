# LastNetwork Cluster Launcher

>
> <https://github.com/LastL2/devops/cluster-launcher>

****

Create ready-to-go Kubernetes clusters for deploying a LastNode on selected providers.

## Requirements

* [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

> Note: Some provider integrations may require additional tools which is outlined in the respective documentation.

## Providers

* [Amazon Web Services](https://docs.last.net/node-operators/kubernetes/setup-aws)
* [Microsoft Azure](https://docs.last.net/node-operators/kubernetes/setup-azure)
* [Digital Ocean](https://docs.last.net/node-operators/kubernetes/setup-digital-ocean)
* [Google Cloud Platform](https://docs.last.net/node-operators/kubernetes/setup-google-cloud)
* [Hetzner Cloud](https://docs.last.net/node-operators/kubernetes/setup-hcloud)

### Volume Snapshots Capabilities

Provider | Enabled
---------|--------
AWS      | yes
Azure    | no
DO       | yes
GCP      | yes
hcloud   | no
Linode   | no

## LastNode

Once you have a Kubernetes cluster up and running, please refer to the [documentation here](https://docs.last.net/node-operators/deploying) to get started with your LastNode.

## Development

### Upgrade

```bash
terraform init -upgrade
```

If installing plugins or modules, ignore previously-downloaded objects and install the latest version allowed within the configured constraints.

### Creating Lockfiles

```bash
terraform providers lock -platform=linux_arm64 -platform=linux_amd64 -platform=darwin_amd64 -platform=windows_amd64
```

Normally the dependency lock file (.terraform.lock.hcl) is updated automatically by "terraform init", but the information available to the normal provider installer can be constrained when you're installing providers from filesystem or network mirrors, and so the generated lock file can end up incomplete.

The "providers lock" subcommand addresses that by updating the lock file based on the official packages available in the origin registry, ignoring the currently-configured installation strategy.

After this command succeeds, the lock file will contain suitable checksums to allow installation of the providers needed by the current configuration on all of the selected platforms.

By default this command updates the lock file for every provider declared in the configuration. You can override that behavior by providing one or more provider source addresses on the command line.
