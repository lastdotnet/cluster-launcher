# THORChain Kubernetes Cluster – Hetzner Cloud

Deploy an **umnanaged** Kubernetes cluster in hcloud.

> Note: This approach is only recommended for experienced operators because the kubernetes control plane among other things needs to be managed manually.

## Requirements

* an hcloud account
* CLI and hcloud credentials configured
* kubectl
* ansible

## Install requirements

### hcloud CLI

In order for Terraform to run operations on your behalf, you must install and configure the hcloud CLI tool. To install the hcloud CLI, follow the [installation guide](https://github.com/hetznercloud/cli#installation) for your system or choose a package manager based on your operating system.

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

To install the kubectl (Kubernetes CLI), follow [these instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl/) or choose a package manager based on your operating system.

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

Use `direnv`, `venv` or whatever you prefer to manage a python environment.

```bash
# Optional
direnv allow

# Optional
virtualenv -p python3 venv
```

Install dependencies required by Python and Ansible Galaxy.

```bash
# Apple Silicon: env LDFLAGS="-L$(brew --prefix openssl@1.1)/lib" CFLAGS="-I$(brew --prefix openssl@1.1)/include"
pip install -r hcloud/ansible/requirements.txt
ansible-galaxy install -r hcloud/ansible/requirements.yml
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
make kubeconfig-hcloud
```

Or get your kubeconfig file manually:

```bash
(cd hcloud && scp $(terraform output -raw hcloud_config) "$HOME/.kube/config-hcloud")
KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-hcloud" kubectl config view --flatten > "$HOME/.kube/tmpcfg" && mv -f "$HOME/.kube/tmpcfg" "$HOME/.kube/config" && kubectl config use-context $(kubectl config current-context --kubeconfig="$HOME/.kube/config-hcloud")
```

Once done, you can check your cluster is responding correctly by running the commands:

```bash
kubectl version
kubectl cluster-info
kubectl get nodes
```

## THORNode Gateway Load Balancer Location

In the `node-launcher` repository, you can edit the `load-balancer.hetzner.cloud/location: nbg1` entry of the `gateway/templates/service.yaml` file. Any of the following locations are valid.

```text
ID   NAME   DESCRIPTION             NETWORK ZONE   COUNTRY   CITY
1    fsn1   Falkenstein DC Park 1   eu-central     DE        Falkenstein
2    nbg1   Nuremberg DC Park 1     eu-central     DE        Nuremberg
3    hel1   Helsinki DC Park 1      eu-central     FI        Helsinki
4    ash    Ashburn, VA             us-east        US        Ashburn, VA
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
