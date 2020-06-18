# Terraform Scripts


****

> **Mirror**
>
> This repo mirrors from THORChain Gitlab to Github.
> To contribute, please contact the team and commit to the Gitlab repo:
>
> https://gitlab.com/thorchain/devops/terraform-scripts


****

====================

Terraform scripts to deploy a Kubernetes cluster for THORNode.

Once you have a Kubernetes cluster up and running, please refer to the
documentation here to get started on how to start the THORNode itself:

https://gitlab.com/thorchain/devops/helm-charts

Terraform is type of domain specific language (DSL) used to describe through
code infrastructure. It designed to make it easier to create/destroy
infrastructure hosted locally or by a provider such as AWS or Digital Ocean.

In choosing a provider, you will find at the root of this repository, a
directory with your provider name. If you do not see it, create it and open a
pull request so that others in the community can benefit from your work.

For more information or how to install the terraform CLI, goto [https://www.terraform.io/](https://www.terraform.io/).

# Providers available

  * AWS [documentation here](docs/aws.md)
  * Digital Ocean [TODO]
