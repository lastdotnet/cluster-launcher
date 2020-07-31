Deploy a Kubernetes cluster in DigitalOcean.


## Requirements
 * an DO account
 * kubectl

## Install requirements

### kubectl

To install the kubectl (Kubernetes CLI), follow [these instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install kubectl.

```bash
brew install kubernetes-cli
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install kubectl.

```bash
choco install kubernetes-cli
```

### wget

To install the wget, follow [these instructions](https://www.gnu.org/software/wget/) or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install wget.

```bash
brew install wget
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install wget.

```bash
choco install wget
```

## Deploy Kubernetes Cluster

Use the commands below to deploy a Kubernetes cluster.

You can run the make command that automates those command for you like this:

```bash
make do
```

Or manually run each commands:

```bash
cd do/
terraform init
terraform plan # to see the plan
terraform apply
```

## Configure kubectl

Now that you've provisioned your Kubernetes cluster, you need to configure kubectl.
By default a kubeconfig file was created at `~/.kube/config-do`, if you don't already have a kubeconfig file
at the default location `~/.kube/config`, then you can rename your DigitalOcean kubeconfig file to the default `~/.kube/config`
expected by kubectl.
If you already have a kubeconfig file at `~/.kube/config`, then you need to manually edit and merge the sections needed from the DigitalOcean kubeconfig.

Once done, you can check your cluster is responding correctly by running the command:

```bash
kubectl version
kubectl get nodes
```

## Clean up your workspace

To destroy and remove previously created resources, you can run the command below.

```bash
make destroy-do
```

Or run the commands manually:

```bash
cd do/
terraform destroy
```
