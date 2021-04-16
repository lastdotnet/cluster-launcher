Deploy a Kubernetes cluster in DigitalOcean.


## Requirements
 * an DO account
 * doctl
 * kubectl

## Install requirements

### doctl

To install the doctl (DigitalOcean CLI), follow [these instructions](https://www.digitalocean.com/docs/apis-clis/doctl/how-to/install/)
or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install kubectl.

```bash
brew install doctl
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install kubectl.

```bash
choco install doctl
```

Create a DigitalOcean API token for your account with read and write access from the [Applications & API page](https://cloud.digitalocean.com/account/api/tokens) in the control panel.
The token string is only displayed once, so save it in a safe place.

Use the API token to grant doctl access to your DigitalOcean account.
Pass in the token string when prompted by doctl auth init, and give this authentication context a name.

```bash
doctl auth init --context <NAME>
```

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
You can follow this [guide](https://www.digitalocean.com/docs/kubernetes/how-to/connect-to-cluster/).

To configure authentication from the command line, use the following command, substituting the name of your cluster.

```bash
make kubeconfig-do
```

This downloads the kubeconfig for the cluster, merges it with any existing configuration from ~/.kube/config,
and automatically handles the authentication token or certificate.

Once done, you can check your cluster is responding correctly by running the command:

```bash
kubectl version
```

Or get your kubeconfig file manually:

```bash
(cd do && az doctl kubernetes cluster kubeconfig save $(terraform output -raw cluster_name))
```

Once done, you can check your cluster is responding correctly by running the commands:

```bash
kubectl version
kubectl cluster-info
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
