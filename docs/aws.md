Deploy a Kubernetes cluster in AWS using EKS service.


## Requirements
 * an AWS account
 * CLI and AWS credentials configured
 * AWS IAM Authenticator
 * kubectl
 * wget (required for eks module)
 * Kubernetes Terraform provider

## Install requirements

### AWS CLI

In order for Terraform to run operations on your behalf,you must install and configure the AWS CLI tool.
To install the AWS CLI, follow [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)
or choose a package manager based on your operating system.

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

### Kubernetes Terraform provider

Use the command below to install Kubernetes Terraform provider,
if the command is outdated or failing, please refer to the [documentation here](https://gavinbunney.github.io/terraform-provider-kubectl/docs/provider.html).

```bash
mkdir -p ~/.terraform.d/plugins && \
    curl -Ls https://api.github.com/repos/gavinbunney/terraform-provider-kubectl/releases/latest \
    | jq -r ".assets[] | select(.browser_download_url | contains(\"$(uname -s | tr A-Z a-z)\")) | select(.browser_download_url | contains(\"amd64\")) | .browser_download_url" \
    | xargs -n 1 curl -Lo ~/.terraform.d/plugins/terraform-provider-kubectl && \
    chmod +x ~/.terraform.d/plugins/terraform-provider-kubectl
```


## Deploy Kubernetes Cluster

Use the commands below to deploy an AWS EKS cluster.

```bash
cd aws/
vim terraform.tfvars # optional
terraform init
terraform plan # to see the plan
terraform apply
```

## Configure kubectl

Kubectl config will be generated at `tf_eks/kubeconfig_<cluster name>`.
You can get the cluster name from the previous output after the succesful Terraform run.
You can view these outputs again by running:

```bash
terraform output
```

Use the command below to export the kubectl configuration generated automatically and check your cluster version:

```bash
export KUBECONFIG=$PWD/tf_eks/kubeconfig_<cluster_name>
kubectl version
```

## Clean up your workspace

To destroy and remove previously created resources, you can run the command below.

```bash
terraform destroy
```
