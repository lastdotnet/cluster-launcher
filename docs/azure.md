Deploy a Kubernetes cluster in Azure using AKS service.


## Requirements
 * an Azure account
 * CLI and Azure credentials configured
 * kubectl

## Install requirements

### Azure CLI

In order for Terraform to run operations on your behalf, you must install and configure the Azure CLI tool.
To install the Azure CLI, follow the [installation guide] for your system (https://docs.microsoft.com/en-us/cli/azure/)
or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the Azure CLI.

```bash
brew install azure-cli
az login
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the Azure CLI.

```bash
choco install azure-cli
az login
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

## Deploy Kubernetes Cluster

Use the commands below to deploy an Azure AKS cluster.

You can run the make command that automates those command for you like this:

```bash
make azure
```

Or manually run each commands:

```bash
cd azure/
terraform init
terraform plan # to see the plan
terraform apply
```

### vCPU quotas

If necessary, request a standard quota increase for the vm's in the regions you want to use.

## Configure kubectl

Now that you've provisioned your AKS cluster, you need to configure kubectl. To configure authentication from the command line, use the following command. It will get the access credentials for your cluster and automatically configure kubectl.

```bash
(cd azure && az aks get-credentials -a -g $(terraform output -raw resource_group) -n $(terraform output -raw cluster_name))
```

Once done, you can check your cluster is responding correctly by running the command:

```bash
kubectl version
```

## Clean up your workspace

To destroy and remove previously created resources, you can run the command below.

```bash
make destroy-azure
```

Or run the commands manually:

```bash
cd azure/
terraform destroy
```
