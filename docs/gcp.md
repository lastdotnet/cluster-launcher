# THORChain Kubernetes Cluster – Google Cloud Platform

Deploy a Kubernetes cluster in GCP using GKE service.

## Requirements

* a GCP account
* CLI and GCP credentials configured
* kubectl

## Install requirements

### gcloud CLI

In order for Terraform to run operations on your behalf, you must install and configure the gcloud CLI tool. To install the gcloud CLI, follow the [installation guide](https://cloud.google.com/sdk/docs/install) for your system or choose a package manager based on your operating system.

MacOS:

Use the package manager [homebrew](https://formulae.brew.sh/) to install the gcloud CLI.

```bash
brew install google-cloud-sdk
```

Windows:

Use the package manager [Chocolatey](https://chocolatey.org/) to install the gcloud CLI.

```bash
choco install gcloudsdk
```

After the installation perform the steps outlined below. This will authorize the SDK to access GCP using your user account credentials and add the SDK to your PATH. It requires you to login and select the project you want to work in. Then add your account to the Application Default Credentials (ADC). This will allow Terraform to access these credentials to provision resources on GCP. Finally, you need to enable the Compute Engine and Kubernetes Engine API services for your GCP project.

```bash
gcloud init
gcloud auth application-default login
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
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

## Deploy Kubernetes Cluster

Use the commands below to deploy an GCP GKE cluster.

You can run the make command that automates those command for you like this:

```bash
make gcp
```

Or manually run each commands:

```bash
cd gcp/
terraform init
terraform plan # to see the plan
terraform apply
```

### Quotas

It may be necessary to increase your quota for various resources in the regions you want to use. You might need to get in touch with the sales team for further assistance.

### Cluster Location

You can choose between a resilient **regional cluster** that spreads across multiple zones of a region having a control plane in each or a **zonal cluster** that resides in a single zone but also only has a single control plane.

Enter either the name of the region like `us-east1` or the name of the zone like `us-east1-a`.

## Configure kubectl

Now that you've provisioned your GKE cluster, you need to configure kubectl.
Customize the following command with your cluster name and resource group. It will get the access credentials for your cluster and automatically configure kubectl.

```bash
make kubeconfig-gcp
```

Or get your kubeconfig file manually:

```bash
(cd gcp && gcloud container clusters get-credentials $(terraform output -raw cluster_name) --region $(terraform output -raw location))
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
make destroy-gcp
```

Or run the commands manually:

```bash
cd gcp/
terraform destroy
```
