Deploy a Kubernetes cluster in Linode using LKE service.

## Requirements

* a Linode account
* linode-cli
* kubectl

## Install requirements

### linode-cli

To install the linode-cli (Linode CLI), follow [these instructions](https://github.com/linode/linode-cli#installation).

You need to have pip (python) on your system.

```bash
pip install linode-cli --upgrade
```

Create a Linode API token for your account with read and write access from your [profile page](https://cloud.linode.com/profile/tokens).
The token string is only displayed once, so save it in a safe place.

Use the API token to grant linode-cli access to your Linode account.
Pass in the token string when prompted by linode-cli.

```bash
linode-cli
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
make linode
```

Or manually run each commands:

```bash
cd linode/
terraform init
terraform plan # to see the plan
terraform apply
```

## Configure kubectl

Now that you've provisioned your Kubernetes cluster, you need to configure kubectl.

To configure authentication from the command line, use the following command.

```bash
make kubeconfig-linode
```

Or get your kubeconfig file manually:

```bash
KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-linode" kubectl config view --flatten > "$HOME/.kube/tmpcfg" && mv -f "$HOME/.kube/tmpcfg" "$HOME/.kube/config" && kubectl config use-context $(kubectl config current-context --kubeconfig="$HOME/.kube/config-linode")
```

> You can also download the file from the [web dashboard](https://cloud.linode.com/kubernetes/clusters).

Once done, you can check your cluster is responding correctly by running the commands:

```bash
kubectl version
kubectl cluster-info
kubectl get nodes
```

## metrics-server

VERY IMPORTANT: On LKE you also need to install a custom metrics-server that allows for `kubelet-insecure-tls`.

```bash
make linode-post # (cd linode && kubectl apply -f metrics-server.yml)
```

## Clean up your workspace

To destroy and remove previously created resources, you can run the command below.

```bash
make destroy-linode
```

Or run the commands manually:

```bash
cd linode/
terraform destroy
```
