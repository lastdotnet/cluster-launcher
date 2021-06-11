# THORChain Kubernetes Cluster – Amazon Web Services

Deploy a Kubernetes cluster in AWS using EKS service.

## Requirements

* an AWS account
* CLI and AWS credentials configured
* AWS IAM Authenticator
* kubectl
* wget (required for eks module)

## Install requirements

### AWS CLI

In order for Terraform to run operations on your behalf, you must install and configure the AWS CLI tool. To install the AWS CLI, follow [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html) or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the AWS CLI.

```bash
brew install awscli
aws configure
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the AWS CLI.

```bash
choco install awscli
aws configure
```

### AWS IAM Authenticator

To install the AWS IAM Authenticator, follow [these instructions](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the AWS IAM Authenticator.

```bash
brew install aws-iam-authenticator
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the AWS IAM Authenticator.

```bash
choco install aws-iam-authenticator
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

Use the commands below to deploy an AWS EKS cluster.

You can run the make command that automates those command for you like this:

```bash
make aws
```

Or manually run each commands:

```bash
cd aws/
terraform init
terraform plan # to see the plan
terraform apply
```

## Configure kubectl

This is done automatically during provisioning. To configure authentication from the command line, use the following command. It will get the access credentials for your cluster and automatically configure kubectl in case you need to to manually reconfigure kubectl.

```bash
make kubeconfig-aws
```

Or get your kubeconfig file manually:

```bash
(cd aws && aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name))
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
make destroy-aws
```

Or run the commands manually:

```bash
cd aws/
terraform destroy
```

## Automated Backups (optional)

Once your node is running, use the following command to automatically backup the Persistent Volumes for your Kubernetes cluster. This may help in recovering your node in the event of a disaster.

Enable backups:

```bash
make aws-backups
```

Disable backups:

```bash
make aws-destroy-backups
```
