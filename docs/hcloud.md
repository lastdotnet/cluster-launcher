Deploy an **umnanaged** Kubernetes cluster in hcloud.

> Note: This approach is only recommended for experienced operators because the kubernetes control plane among other things needs to be managed manually.

## Requirements

* an hcloud account
* CLI and hcloud credentials configured
* kubectl
* ansible

## Install requirements

### hcloud CLI

In order for Terraform to run operations on your behalf, you must install and configure the hcloud CLI tool.
To install the hcloud CLI, follow the [installation guide](https://github.com/hetznercloud/cli#installation) for your system
or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the hcloud CLI.

```bash
brew install hcloud
hcloud context create <project_name>
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the hcloud CLI.

```bash
choco install hcloud
hcloud context create <project_name>
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

## Environment

Initialize the git submodule.

```bash
git submodule update --init
```

Use `direnv`, `venv` or whatever you prefer to manage a python environment inside the hcloud folder.

```bash
# Optional
(cd hcloud && direnv allow)

# Optional
(cd hcloud && virtualenv -p python3 venv)
```

Install dependencies required by Python and Ansible Galaxy.

```bash
(cd hcloud && pip install -r ansible/requirements.txt)
(cd hcloud && ansible-galaxy install -r ansible/requirements.yml)
```

## Deploy Kubernetes Cluster

Use the commands below to deploy a kubernetes cluster.

You can run the make command that automates those command for you like this:

```bash
make hcloud
```

Or manually run each commands:

```bash
cd hcloud/
terraform init
terraform plan # to see the plan
terraform apply
(cd ansible && make provision)
```

### Quotas

If necessary, request a quota increase [here](https://console.hetzner.cloud/limits).

## Configure kubectl

Now that you've provisioned your kubernetes cluster, you need to configure kubectl.
The following command will get the access credentials for your cluster.

```bash
(cd hcloud && scp $(terraform output -raw hcloud_config) ~/.kube/config-hcloud)

# Merge it and set current context
KUBECONFIG=~/.kube/config:~/.kube/config-hcloud kubectl config view --flatten > ~/.kube/tmpcfg && mv -f ~/.kube/tmpcfg ~/.kube/config && kubectl config use-context $(kubectl config current-context --kubeconfig=$HOME/.kube/config-hcloud)

kubectl version
```

## Clean up your workspace

To destroy and remove previously created resources, you can run the command below.

```bash
make destroy-hcloud
```

Or run the commands manually:

```bash
cd hcloud/
terraform destroy
```
