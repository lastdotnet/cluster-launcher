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

## Setting up kubectl
Once you have run a terraform script and created your infrastructure on AWS or
another provider. Next is setting up kubctl. If you haven't installed kubectl
already, [please do
so](https://kubernetes.io/docs/tasks/tools/install-kubectl/). 

Within the same directory as the provider you used to generate your
infrastructure (ie `/aws`), run the following to configure your kubectl

```
mkdir ~/.kube/
terraform output kubeconfig > ~/.kube/config
```

You should now be able to run the following...
```
$ kubectl version                                    
Client Version: version.Info{Major:"1", Minor:"16+", GitVersion:"v1.16.6-beta.0", GitCommit:"e7f962ba86f4ce7033828210ca3556393c377bcc", GitTreeState:"clean", BuildDate:"2020-01-15T08:26:26Z", GoVersion:"go1.13.5", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"16+", GitVersion:"v1.16.8-eks-e16311", GitCommit:"e163110a04dcb2f39c3325af96d019b4925419eb", GitTreeState:"clean", BuildDate:"2020-03-27T22:37:12Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```

**NOTE** if you get an `aws-iam-authenticator` error, you may need to [install it](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)


```
terraform output config_map_aws_auth > configmap.yml
kubectl apply -f configmap.yml
```
