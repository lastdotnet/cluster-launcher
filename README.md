# terraform-scripts

Terraform Scripts for deploying a THORNode

Terraform is type of domain specific language (DSL) used to describe through
code infrastructure. It designed to make it easier to create/destroy
infrastructure hosted locally or by a provider such as AWS or Digital Ocean.

In choosing a provider, you will find at the root of this repository, a
directory with your provider name. If you do not see it, create it and open a
pull request so that others in the community can benefit from your work.

For more information or how to install the terraform CLI, goto
[https://www.terraform.io/](https://www.terraform.io/)


1. Install kubernetes provider as documented at https://gavinbunney.github.io/terraform-provider-kubectl/docs/provider.html which allows manifests application.

2. Configure AWS credentials, [follow the guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

3. Change directory to `tf_eks`, update `terraform.tfvars` if needed, run `terraform init` and `terraform apply`.

## Setting up kubectl
If you haven't installed kubectl
already, [please do so](https://kubernetes.io/docs/tasks/tools/install-kubectl/). 

1. Kubectl config will be generated at `tf_eks/kubeconfig_<cluster name>`.

2. Execute `export KUBECONFIG=$PWD/tf_eks/kubeconfig_<cluster name>`,  you should now be able to run the following...

```
$ kubectl version                                    
Client Version: version.Info{Major:"1", Minor:"16+", GitVersion:"v1.16.6-beta.0", GitCommit:"e7f962ba86f4ce7033828210ca3556393c377bcc", GitTreeState:"clean", BuildDate:"2020-01-15T08:26:26Z", GoVersion:"go1.13.5", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"16+", GitVersion:"v1.16.8-eks-e16311", GitCommit:"e163110a04dcb2f39c3325af96d019b4925419eb", GitTreeState:"clean", BuildDate:"2020-03-27T22:37:12Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```

**NOTE** if you get an `aws-iam-authenticator` error, you may need to [install it](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)